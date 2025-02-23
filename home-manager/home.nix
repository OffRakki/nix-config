# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
	nix-colors = import <nix-colors> { };
   in {
  imports = [
	inputs.nix-colors.homeManagerModule
	./modules
	./home-packages.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "rakki";
    homeDirectory = "/home/rakki";
    pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    };
  };
  gtk = {
   enable = true;
 };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ steam emacs ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
  	enable = true;
	package = pkgs.gitAndTools.gitFull;
	userName = "OffRakki";
	userEmail = "fernandomarques1505@gmail.com";
	extraConfig = {
		color.ui = "auto";
	};
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
