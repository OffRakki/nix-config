{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
    wayland.windowManager.hyprland = {
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
      ];
      settings = {
        "plugin:hyprscrolling" = {
          fullscreen_on_one_column = true;
          focus_fit_method = 1; # fit to screen
          column_width = 0.5;
        };
      };
    };
  }
