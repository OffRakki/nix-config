{
  config,
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package= pkgs.gruvbox-dark-icons-gtk;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
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
