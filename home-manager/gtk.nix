{
  config,
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package= pkgs.gruvbox-dark-icons-gtk;
    };
    font = {
      name = "FiraSans";
      size = 12;
    };
    gtk3 = {
      enable = true;
      extraConfig.Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig.Settings = ''
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
      "Net/ThemeName" = "gruvbox-dark";
      "Net/IconThemeName" = "oomox-gruvbox-dark";
    };
  };
}
