{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    	inputs.home-manager.nixosModules.home-manager

	../hosts/rakki/config.nix
	./modules

	../modules/nixosconfig/hyprland.nix

	#../modules/i3enableconfig.nix
    
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
      # neovim-nightly-overlay.overlays.default

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
    neovim	
    wget
    bat
    curl
    git
    rofi
    home-manager
    fish
    kitty
    firefox
    starship
    fastfetch
    wayland
    wireplumber
    pipewire
    pwvucontrol
    pipecontrol
    btop
    google-chrome
    qutebrowser
    wasistlos
    vesktop
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
    };
    # Opinionated: disable channels
    channel.enable = true;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = "igris";

  users = {
    defaultUserShell = "${pkgs.fish}/bin/fish";
    mutableUsers = true;
    users = {
        rakki = {
          initialPassword = "123123123";
          isNormalUser = true;
          openssh.authorizedKeys.keys = [
            # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
          ];
          extraGroups = [
            "networkmanager"
            "wheel"
            "libvirtd"
            "scanner"
            "lp"
            "video" 
            "input" 
            "audio"
          ];
	packages = with pkgs; [  ];
        };
    };
  };
  
  environment.shells = with pkgs ; [ fish ];

  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = ["git"];
    theme = "rkj-mod"; 
  };

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
  system.stateVersion = "24.11";
}
