{
  description = "yeah!";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    # Ministerio
    ministerio.url = "github:misterio77/nix-config";

    # Games
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

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
    home-manager,
		nvf,
    alejandra,
    hyprland,
    hyprland-plugins,
    ...
  } @inputs: 
		let
    	inherit (self) outputs;
  	in {
    	# NixOS configuration entrypoint
    	# Available through 'nixos-rebuild --flake .#your-hostname'
    	nixosConfigurations = {
      	igris = nixpkgs.lib.nixosSystem {
        	specialArgs = {
						inherit inputs;
						inherit outputs;
					};
        	# Main config file
        	modules = [
          	inputs.nvf.nixosModules.default
						./nixos/configuration.nix
					];
      	};
    	};
    	homeConfigurations.rakki = home-manager.lib.homeManagerConfiguration {
    	  specialArgs = {
    	    inherit inputs;
    	    inherit outputs;
    	  };
    	  pkgs = nixpkgs.legacyPackages.x86_64-linux;
    	  modules = [
  				./home-manager/home.nix
    	  ];
    	};
    };
}
