{
  description = "!";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";

    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";

    # nix-colors
    nix-colors.url = "github:misterio77/nix-colors";
		
		# Stylix
		stylix.url = "github:danth/stylix";

    # Games
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

		# Nixvim
		nixvim.url = "github:nix-community/nixvim";

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
    stylix,
    nixvim,
    ...
  } @inputs: let
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
					./nixos/configuration.nix
					inputs.stylix.nixosModules.stylix
				];
      };
    };
  };
}
