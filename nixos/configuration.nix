{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {
	
	# Stylix
	stylix = lib.mkForce {
		enable = true;
		#base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
		autoEnable = true;
		image = ../hosts/rakki/wallpapers/knnw.jpg;
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Amber";
			size = 24;
		};
		fonts = {
			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrainsMono Nerd Font Mono";
			};
		};
		polarity = "dark"; # "dark", "light" or "either"
	};

	virtualisation.libvirtd = lib.mkForce {
		enable = true;
  	allowedBridges = [ "virbr0" ];
	};

  # You can import other NixOS modules here
  imports = [
    	inputs.home-manager.nixosModules.home-manager

		../hosts/rakki/config.nix
		./modules

		../modules/nixosconfig/hyprland.nix

		#../modules/i3enableconfig.nix
    
		./hardware-configuration.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

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


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
		vulkan-tools
		nushell
		tmux
    evil-helix
    sublime
    neovim	
    wget
    bat
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
  ];

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

  networking.hostName = "igris";

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
  time.timeZone = lib.mkDefault "America/Sao_Paulo";


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
