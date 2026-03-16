{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.noctalia.homeModules.default
    inputs.walker.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.spicetify
    ./modules
    ./home-packages.nix
    ./gtk.nix
    ./qt.nix
    ./oama.nix
    ./xdg-portals.nix
    ./persistence.nix
    ./onedrive.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "rakki";
    homeDirectory = "/home/rakki";
    sessionVariables = {
      NH_FLAKE = "$HOME/Documents/NixConfig";
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
        "text/html" = ["floorp.desktop"];
        "text/xml" = ["floorp.desktop"];
        "x-scheme-handler/http" = ["floorp.desktop"];
        "x-scheme-handler/https" = ["floorp.desktop"];
        "application/pdf" = ["evince.desktop"];
        "inode/directory" = ["nemo.desktop;pcmanfm-qt"];
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

  # Nicely reload system units when changing configs
  systemd.user = {
    startServices = "sd-switch";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
