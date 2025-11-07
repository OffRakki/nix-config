# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  nix-colors = import <nix-colors> {};
in {
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeModules.nixvim
    inputs.nvf.homeManagerModules.default
    ./modules
    ./home-packages.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

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

  # stylix.targets    = {
  #   nixcord.enable  = true;
  #   vencord.enable  = true;
  #   vesktop.enable  = true;
  #   swaync.enable   = true;
  #   mangohud.enable = true;
  #   gtk.enable      = true;
  #   kde.enable      = true;
  # };

  home = {
    username = "rakki";
    homeDirectory = "/home/rakki";
  };
  gtk = {
    enable = true;
  };

  # Enable home-manager
  programs.home-manager.enable = true;
  wayland.windowManager.hyprland.systemd.enable = false;

  # Nicely reload system units when changing configs
  #systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
