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
    inputs.caelestia-shell.homeManagerModules.default
    ./modules
    ./home-packages.nix
    ./gtk.nix
    ./qt.nix
    ./oama.nix
    ./xdg-portals.nix
  ];

  home = {
    username = "rakki";
    homeDirectory = "/home/rakki";
    sessionVariables = {
      NH_FLAKE = "$HOME/Documents/nixConfig";
      QT_QPA_PLATFORM = "wayland";
      TERMINAL = "kitty";
    };
  };
  
	dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
	};
  
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = lib.mkBefore {
        "application/pdf"        = [ "evince.desktop"        ];
    	  "text/html"              = [ "brave-browser.desktop" ];
        "text/xml"               = [ "brave-browser.desktop" ];
        "x-scheme-handler/http"  = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];
        "inode/directory"        = [ "pcmanfm-qt.desktop"    ];
        "text/plain"             = [ "helix.desktop"         ];
        "text/x-ini"             = [ "helix.desktop"         ];
        "application/x-ini"      = [ "helix.desktop"         ];
        "text/markdown"          = [ "helix.desktop"         ];
      };
    };
    desktopEntries = {
      helix = {
        name = "Helix";
        genericName = "Text Editor";
        exec = "kitty -e hx %F";
        terminal = false;
        categories = [ "Utility" "TextEditor" ];
        # Adding Markdown here helps file managers "discover" Helix for .md files
        mimeType = [ 
          "text/plain" 
          "text/markdown" 
          "text/x-ini" 
          "application/x-ini" 
        ];
      };
    };
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
