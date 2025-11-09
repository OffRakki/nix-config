{config, pkgs, lib, ...}: {
  programs.alacritty = lib.mkForce {
    enable = true;
    settings = {
      terminal.shell = "${pkgs.fish}/bin/fish";
      font = {
        size = 12;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
      };
      window = {
        opacity = 0.85;
        blur = true;
      };
    };
  };
}
