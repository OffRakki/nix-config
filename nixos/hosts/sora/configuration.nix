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
    ../../modules
    ./config.nix
    ./hardware-configuration.nix
  ];

  programs.river-classic.enable = true;
  programs.river-classic.xwayland.enable = true;

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
      rakki = import ../../../home-manager/home.nix;
    };
  };

  sops = {
    defaultSopsFile = ../../secrets.yaml;

    secrets.syncthing_cert = {
      owner = "rakki";
    };
    secrets.syncthing_key = {
      owner = "rakki";
    };

    secrets.user-password = {
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

  console.useXkbConfig = true;

  programs = {
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
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
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

  # Defaults sudo-rs as sudo
  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
    wrappers.sudo-rs = {
      #source = "${lib.getExe pkgs.sudo-rs}";
      source = "${lib.getExe pkgs.sudo-rs}";
      setuid = true;
      setgid = true;
      owner = "0";
      group = "0";
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
