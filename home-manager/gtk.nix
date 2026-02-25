{pkgs, ...}: let
  colloidGruvbox = pkgs.colloid-gtk-theme.override {
    tweaks = ["gruvbox"];
    colorVariants = ["dark"];
  };
  themeName = "Colloid-Dark-Gruvbox";
in {
  home.sessionVariables = {
    GTK_THEME = themeName;
    ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = themeName;
      package = colloidGruvbox;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    font = {
      name = "FiraSans";
      size = 12;
    };
    gtk3 = {
      enable = true;
      extraConfig.settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig.settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      x11 = {
        enable = true;
        defaultCursor = "catppuccin-mocha-peach-cursors";
      };
      package = pkgs.catppuccin-cursors.mochaPeach;
      name = "catppuccin-mocha-peach-cursors";
      size = 24;
    };
  };
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = themeName;
      "Net/IconThemeName" = "Gruvbox-Plus-Dark";
    };
  };
}
