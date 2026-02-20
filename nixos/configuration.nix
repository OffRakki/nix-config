{ inputs, lib, config, pkgs, outputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
		../hosts/sora/config.nix
		./modules
		./hardware-configuration.nix
		./variables.nix
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
  
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users = {
      # Import your home-manager config
      rakki = import ../home-manager/home.nix;
    };
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/home/rakki/.config/sops/age/keys.txt";

    secrets.syncthing_cert = { owner = "rakki"; };
    secrets.syncthing_key = { owner = "rakki"; };

    secrets.user-password = {
      neededForUsers = true;
    };
  };

  console.useXkbConfig = true;

  programs = {
    gpu-screen-recorder.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [fuse glib];
    };

    appimage = {
      enable = true;
      binfmt = true;
    };

    hyprland = {
      enable = true;
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

  services = {
    mpd= {
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
      xkb = {
        layout = "us";
        variant = "intl";
      };
    };
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
    openssh = {
      enable = true;
      settings = {
        # Opinionated: forbid root login through SSH.
        PermitRootLogin = "no";
        # Opinionated: use keys only.
        PasswordAuthentication = true;
      };
    };
  };

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sops
    age
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    dotool
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
    fzf
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
  ];

  time.timeZone = lib.mkDefault "America/Sao_Paulo";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
