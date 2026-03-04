{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.hyprland.nixosModules.default
    ../../modules
    ./containers
    ./hardware-configuration.nix
    ./packages.nix
    ./fonts.nix
    ./users.nix
    ./tailscale.nix
  ];

  nixpkgs = {
    overlays = [
      (final: _: {
        inputs =
          builtins.mapAttrs (
            _: flake: let
              legacyPackages = (flake.legacyPackages or {}).${final.stdenv.system} or {};
              packages = (flake.packages or {}).${final.stdenv.system} or {};
            in
              packages // legacyPackages
          )
          inputs;
        caelestia-shell = inputs.caelestia-shell.packages.${pkgs.system}.caelestia-shell;
        caelestia-cli = inputs.caelestia-shell.inputs.caelestia-cli.packages.${pkgs.system}.caelestia-cli;
      })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users = {
      # Import your home-manager config
      rakki = import ../home-manager/home.nix;
    };
  };

  sops = {
    defaultSopsFile = ../../../secrets.yaml;

    secrets.syncthing_cert = {
      owner = "rakki";
    };
    secrets.syncthing_key = {
      owner = "rakki";
    };

    secrets.soraPass = {
      neededForUsers = true;
    };

    secrets.onedriveToken = {
      owner = "rakki";
    };
  };

  sops.templates."rclone-onedrive.conf" = {
    owner = "rakki";
    content = ''
      [onedrive]
      type = onedrive
      token = ${config.sops.placeholder.onedriveToken}
      drive_id = FA1D85EC1252599A
      drive_type = personal
    '';
  };

  environment.sessionVariables = {
    __GL_SHADER_DISK_CACHE = 1;
    __GL_SHADER_DISK_CACHE_PATH = "/home/rakki/.nv/shaderCache";
    __GL_SHADER_DISK_CACHE_SIZE = 107374182400; # 100GB
    # __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = 1; # Essentially unlimited cache
    AQ_DRM_DEVICES = "/dev/dri/card1";
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    QT_QPA_PLATFORM = "wayland";
    CLUTTER_BACKEND = "wayland";
    EGL_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11";
    GDK_SCALE = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    MOZ_ENABLE_WAYLAND = 1;
    WLR_NO_HARDWARE_CURSORS = 1;
    PROTON_USE_NTSYNC = 1;
    TERMINAL = "kitty";
    EDITOR = "hx";
  };

  console.useXkbConfig = true;

  programs = {
    river-classic = {
      enable = true;
      xwayland.enable = true;
    };

    gpu-screen-recorder.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        fuse
        glib
      ];
    };

    appimage = {
      enable = true;
      binfmt = true;
    };

    hyprland = {
      enable = true;
      withUWSM = false;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    dconf.enable = true;

    direnv.nix-direnv.enable = true;

    java = {
      enable = true;
      package = pkgs.jre;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      accept-flake-config = true;
      # Enable flakes and new 'nix' command
      experimental-features = ["nix-command flakes"];
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround to get rid of the download buffer size warning
      download-buffer-size = 524288000;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
    wrappers.sudo-rs = {
      source = "${lib.getExe pkgs.sudo-rs}";
      setuid = true;
      setgid = true;
      owner = "0";
      group = "0";
    };
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      })
    '';
    pam.services = {
      gdm-password.enableGnomeKeyring = true;
      hyprlock = {};
    };
  };

  virtualisation.libvirtd.enable = true;

  services = {
    mpd = {
      enable = true;
      user = "rakki";
      settings = {
        music_directory = "/home/rakki/Music";
        audio_output = [
          {
            type = "pipewire";
            name = "Pipewire_Output";
          }
        ];
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = false;
      };
      xkb = {
        layout = "us";
        variant = "intl";
      };
    };
    displayManager = {
      sessionPackages = [
        pkgs.hyprland
      ];
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
          kdePackages.qt5compat
        ];
        settings = {
          Wayland = {
            # File to tell which monitor the SDDM should go *see environment.etc*
            CompositorCommand = "${pkgs.weston}/bin/weston --shell=kiosk -c /etc/sddm-weston.ini";
          };
        };
      };
    };
    openssh = {
      enable = true;
      settings = {
        # Opinionated: forbid root login through SSH.
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
      hostKeys = [
        {
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
    dbus = {
      packages = [
        pkgs.gsettings-desktop-schemas
        pkgs.dconf
      ];
    };
    smartd = {
      enable = true;
      autodetect = true;
    };

    gvfs.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    pulseaudio.enable = false; # unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;

    flatpak.enable = true;

    blueman.enable = true;

    fwupd.enable = true;

    upower.enable = true;

    gnome.gnome-keyring.enable = true;

    printing = {
      enable = false;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };
    ipp-usb.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment = {
    etc."sddm-weston.ini".text = ''
      [output]
      name=HDMI-A-1
      mode=off

      [output]
      name=DP-1
      mode=preferred
    '';
  };

  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  systemd = {
    services = {
      mpd = {
        environment = {
          XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.rakki.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
        };
      };
    };
    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
    user.extraConfig = ''
      DefaultTimeoutStopSec=10s;
    '';
  };

  time.timeZone = lib.mkDefault "America/Sao_Paulo";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
