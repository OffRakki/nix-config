# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.caelestia-shell.homeManagerModules.default
    inputs.walker.homeManagerModules.default
    ./modules
    ./home-packages.nix
    ./gtk.nix
    ./qt.nix
    ./oama.nix
    ./xdg-portals.nix
    ./persistence.nix
    ./onedrive.nix
  ];

  home = {
    username = "rakki";
    homeDirectory = "/home/rakki";
    sessionVariables = {
      XCURSOR_THEME = "catppuccin-mocha-peach-cursors";
      XCURSOR_SIZE = "24";
      NH_FLAKE = "$HOME/Documents/NixConfig";
      QT_QPA_PLATFORM = "wayland";
      TERMINAL = "kitty";
    };
    persistence."/persist".directories = [
      "Documents"
      "Downloads"
      "Pictures"
      "Videos"
      ".local/bin"
      ".local/share/nix" # trusted settings and repl history
    ];
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
        "image/jpeg" = ["imv.desktop"];
        "image/jpg" = ["imv.desktop"];
        "image/png" = ["imv.desktop"];
        "image/gif" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
        "image/bmp" = ["imv.desktop"];
        "image/svg" = ["imv.desktop"];
        "image/x-tga" = ["imv.desktop"];
        "text/plain" = ["helix.desktop"];
        "text/x-ini" = ["helix.desktop"];
        "application/x-ini" = ["helix.desktop"];
        "text/markdown" = ["helix.desktop"];
        "text/html" = ["brave-browser.desktop"];
        "text/xml" = ["brave-browser.desktop"];
        "x-scheme-handler/http" = ["brave-browser.desktop"];
        "x-scheme-handler/https" = ["brave-browser.desktop"];
        "application/pdf" = ["evince.desktop"];
        "inode/directory" = ["pcmanfm-qt.desktop"];
      };
    };
    desktopEntries = {
      imv = {
        name = "imv";
        genericName = "Image Viewer";
        exec = "imv %F";
        terminal = false;
        categories = [
          "Graphics"
          "Viewer"
        ];
        mimeType = [
          "image/jpeg"
          "image/jpg"
          "image/png"
          "image/gif"
          "image/webp"
          "image/bmp"
          "image/svg"
        ];
      };
      helix = {
        name = "Helix";
        genericName = "Text Editor";
        exec = "kitty -e hx %F";
        terminal = false;
        categories = [
          "Utility"
          "TextEditor"
        ];
        mimeType = [
          "text/plain"
          "text/markdown"
          "text/x-ini"
          "application/x-ini"
        ];
      };
      whatsappWeb = {
        name = "Whatsapp";
        genericName = "Web Whatsapp";
        exec = "brave --app=https://web.whatsapp.com";
        terminal = false;
        categories = [
          "Network"
          "WebBrowser"
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
