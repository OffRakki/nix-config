{
  description = "yeah!";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-parts.url = "github:hercules-ci/flake-parts";

    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
		
		# Stylix
		stylix.url = "github:nix-community/stylix";

    # Games
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

		# Nixvim
		nixvim.url = "github:nix-community/nixvim";
    
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
    stylix,
    nixvim,
		nvf,
    alejandra,
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
          	inputs.stylix.nixosModules.default
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
  				inputs.stylix.homeModules.stylix
  				./home-manager/home.nix
    	  ];
    	};
    };
}
