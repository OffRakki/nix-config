# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.niri.homeModules.niri
    inputs.nvf.homeManagerModules.default
    inputs.caelestia-shell.homeManagerModules.default
    ./modules
    ./home-packages.nix
    ./gtk.nix
    ./qt.nix
    ./oama.nix
    ./xdg-portals.nix
    ../nixos/variables.nix
  ];

  home = {
    username = "rakki";
    homeDirectory = "/home/rakki";
    sessionVariables = {
      NH_FLAKE = "$HOME/Documents/nixConfig";
      QT_QPA_PLATFORM = "wayland";
    };
  };
  
	dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
	};
  
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.mkBefore {
      "application/pdf" = "evince.desktop";
  	  "text/html" = ["brave-browser.desktop"];
      "text/xml" = ["brave-browser.desktop"];
      "x-scheme-handler/http" = ["brave-browser.desktop"];
      "x-scheme-handler/https" = ["brave-browser.desktop"];    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user = {
    startServices = "sd-switch";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
