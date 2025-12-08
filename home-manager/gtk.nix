{
  config,
  pkgs,
  lib,
  ...
}:{
  home.sessionVariables = {
    GTK_THEME = "catppuccin-mocha-lavender-standard+normal";
  };
    
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "catppuccin-mocha-lavender-standard+normal";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "standard";
        tweaks = ["normal"];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package= pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
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
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaPeach;
    name = "Catppuccin-Mocha-Peach";
    size = 24;
  };
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "catppuccin-mocha-lavender-standard+normal";
      "Net/IconThemeName" = "Papirus-Dark";
    };
  };
}
