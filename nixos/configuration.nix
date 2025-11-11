{ inputs, lib, config, pkgs, outputs, ... }:
{
  # You can import other NixOS modules here
  imports = [
    inputs.home-manager.nixosModules.home-manager
		../hosts/rakki/config.nix
		./modules
		./hardware-configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "backup";
    users = {
      # Import your home-manager config
      rakki = import ../home-manager/home.nix;
    };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      #neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
			# Workaround to get rid of the download buffer size warning
			download-buffer-size = 524288000;
    };
    # Opinionated: disable channels
    channel.enable = true;

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

	virtualisation = {
    docker.enable = true;
    libvirtd = lib.mkForce {
		enable = true;
    };
	};

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  services.tailscale.enable = true;

  services.mpd= {
    enable = true;
    musicDirectory = "/home/rakki/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire_Output"
      }
    '';
  };
  services.mpd.user = "rakki";
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.rakki.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };

  # Enable this to change to xserver + i3
	services.xserver = {
		enable = false;
    xkb = {
      layout = "us";
      variant = "intl";
    };
		autorun = false;
		displayManager.startx.enable = false;
		windowManager.i3.enable = false;
	};

  console = {
    useXkbConfig = true;
  };

	programs.dconf.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jre;
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    networkmanager
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
    sublime
    neovim
    wget
    curl
    rofi
    home-manager
    fish
    kitty
    firefox
    starship
    fastfetch
    wireplumber
    pipewire
    pwvucontrol
    pipecontrol
    btop
    google-chrome
    qutebrowser
    wasistlos
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
    grc
  ];

  networking.hostName = "igris";

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
