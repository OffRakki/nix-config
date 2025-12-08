{config, pkgs, lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = "${pkgs.fish}/bin/fish";
      font = {
        size = 11;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
      };
      window = {
        dynamic_title = true;
        # opacity = 0.85;
        blur = true;
        padding = {
          x = 4;
          y = 4;
        };
      };
      colors = {
        primary = {
          background = "#11111b";
        };
      };
    };
  };
}
