{
  description = "nvf config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nvf.url = "github:notashelf/nvf";
  };
  
  outputs = { self, nixpkgs, nvf, ... }: 
  let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in
  {
    packages."x86_64-linux".NVFneovim =
      (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./nvf_config.nix ];
      }).neovim;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
	  ./configuration.nix
          nvf.nixosModules.default
				];
      };
    };
  }
