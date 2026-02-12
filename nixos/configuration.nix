{ inputs, lib, config, pkgs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
		../hosts/rakki/config.nix
		./modules
		./hardware-configuration.nix
  ];

  nixpkgs ={
    overlays = [(final: _: {
      inputs =
        builtins.mapAttrs (
          _: flake: let
            legacyPackages = (flake.legacyPackages or {}).${final.stdenv.system} or {};
            packages = (flake.packages or {}).${final.stdenv.system} or {};
          in
            packages // legacyPackages
        )
        inputs;
    })];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [fuse glib];
  };

  programs.appimage = {
  enable = true;
  binfmt = true;
};
  
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users = {
      # Import your home-manager config
      rakki = import ../home-manager/home.nix;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = [ "nix-command flakes"] ;
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

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  services.tailscale.enable = true;

  services.mpd= {
    enable = true;
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
  services.mpd.user = "rakki";
  
  systemd = {
    services = {
      podman-glance = {
        restartIfChanged = false;
      };
      mpd = {
        environment = {
          XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.rakki.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
        };
      };
    };
  };

	services.xserver = {
		enable = true;
    xkb = {
      layout = "us";
      variant = "intl";
    };
  };
		services = {
		  displayManager = {
        sessionPackages = [
          inputs.niri.packages.${pkgs.system}.niri-unstable
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
  		  };
  		};
		};

  console.useXkbConfig = true;

	programs.dconf.enable = true;

  programs.direnv.nix-direnv.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jre;
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dotool
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    appimage-run
    grc
    xwayland-satellite
    xwayland
    xwayland-run
    localsend
    sddm-astronaut
    sddm-sugar-dark
    niriswitcher
    fuzzel
    netplan
    jujutsu
    discordo
    syncthing
    kdePackages.kde-cli-tools
    dialog
    freerdp
    iproute2
    libnotify
    nmap
    netcat
    hypridle
    tailscale
    nyxt
    sudo-rs
    mprime
    nh
    nix-output-monitor
    diffutils
    matugen
    oama
    pass
    msmtp
    uutils-coreutils-noprefix
    ueberzugpp
    ueberzug
    w3m
    direnv
    dragon-drop
    networkmanager
    refind
    os-prober
    nixd
		vulkan-tools
		nushell
		tmux
    evil-helix
    # sublime
    neovim
    wget
    curl
    rofi
    kitty
    firefox
    starship
    fastfetch
    wireplumber
    pwvucontrol
    pipecontrol
    btop
    qutebrowser
    vesktop
		waybar-mpris
    wl-clipboard-rs
    wl-clip-persist
    clipse
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
  ];

  networking.hostName = "sora";

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      PasswordAuthentication = true;
    };
  };

   # Set your time zone.
   time.timeZone = lib.mkDefault "America/Sao_Paulo";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
