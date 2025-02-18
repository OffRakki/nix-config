{
  description = "NixOS awesome configuration!";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";


    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    hyrpland-plugins = {
    	url = "github:hyprwm/hyprland_plugins";
	inputs.hyprland.follows = "hyprland";
	};

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
    hyprland,
    ...
  } @ inputs: let
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
        modules = [./nixos/configuration.nix];
      };
    };
  };
}
