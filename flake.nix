{
  description = "declarative mess";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Secrets
    sops-nix.url = "github:Mic92/sops-nix";

    # WM
    caelestia-shell.url = "github:caelestia-dots/shell";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    # Ministerio
    ministerio.url = "github:misterio77/nix-config";

    # Games
    hytale = {
      url = "github:TNAZEP/HytaleLauncherFlake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  outputs = {
    self,
    nixpkgs,
    caelestia-shell,
    home-manager,
    catppuccin,
    ...
  } @inputs:  {
  	nixosConfigurations = {
    	sora = nixpkgs.lib.nixosSystem {
      	specialArgs = {
					inherit inputs;
					inherit (self) outputs;
				};
      	modules = [
					./nixos/hosts/sora/configuration.nix
				];
    	};
  	};
  };
}
