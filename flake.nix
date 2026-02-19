{
  description = "declarative mess";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Secrets
    sops-nix.url = "github:Mic92/sops-nix";

    # WM
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    caelestia-shell.url = "github:caelestia-dots/shell";

    niri.url = "github:sodiboo/niri-flake";


    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    # Ministerio
    ministerio.url = "github:misterio77/nix-config";

    # Games
    hytale = {
      url = "github:TNAZEP/HytaleLauncherFlake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NVF (modular neovim)
    nvf.url = "github:notashelf/nvf";

    # Home manager
    home-manager = {
    url = "github:nix-community/home-manager";

    inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    caelestia-shell,
    home-manager,
    catppuccin,
		nvf,
    alejandra,
    hyprland,
    hyprland-plugins,
    niri,
    ...
  } @inputs: 
		let
    	inherit (self) outputs;
    	system = "x86_64-linux";
  	in {
    	nixosConfigurations = {
      	sora = nixpkgs.lib.nixosSystem {
        	specialArgs = {
						inherit inputs;
						inherit outputs;
					};
        	modules = [
        	  # inputs.niri.homeModules.niri
          	inputs.nvf.nixosModules.default
						./nixos/configuration.nix
						{
						  nixpkgs.overlays = [
						    (final: prev: {
						      caelestia-shell = caelestia-shell.packages.${system}.caelestia-shell;
						      caelestia-cli   = caelestia-shell.inputs.caelestia-cli.packages.${system}.caelestia-cli;
						    })
						  ];
						}
					];
      	};
    	};
    };
}
