{
  description = "Declarative mess";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
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
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nuls = {
      url = "github:cesarferreira/nuls";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # WM
    hyprland.url = "github:hyprwm/Hyprland";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    hardware.url = "github:nixos/nixos-hardware";

    kopuz.url = "github:kopuz-org/kopuz";

    # Ministerio
    ministerio.url = "github:misterio77/nix-config";

    # Games
    # millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    hytale = {
      url = "github:TNAZEP/HytaleLauncherFlake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # OpenGL/Vulkan wrapper
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://kopuz.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "kopuz.cachix.org-1:J2X3AnAYhKTJW5S3aCLoA1ckonQXVNZMQvhZA0YAufw="
    ];
  };

  outputs = {
    self,
    nixpkgs,
    noctalia,
    nix-minecraft,
    # millennium,
    nuls,
    home-manager,
    catppuccin,
    hyprland,
    nixgl,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra; # Default .nix code formatter
    nixosConfigurations = {
      sora = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit (self) outputs;
        };
        modules = [
          ./hosts/sora/nixos/configuration.nix
        ];
      };
      tempest = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit (self) outputs;
        };
        modules = [
          ./hosts/tempest/nixos/configuration.nix
        ];
      };
    };
  };
}
