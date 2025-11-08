{
  config,
  pkgs,
  lib,
  ...
}: let

  hyprbars = pkgs.hyprland.stdenv.mkDerivation {
    pname = "hyprbars";
    version = "0.51.0";

    src = "${pkgs.fetchFromGitHub {
      owner = "hyprwm";
      repo = "hyprland-plugins";
      rev = "a5a6f93d72d5fb37e78b98c756cfd8b340e71a19";
      hash = "sha256-wyS6tXYJuzbwckOeaCoRtT4qIG2UZ0YvSZx7EBNjTV0=";
    }}/hyprbars";
    buildInputs = [pkgs.hyprland] ++ pkgs.hyprland.buildInputs;
    nativeBuildInputs = [pkgs.pkg-config pkgs.cmake];
  };
in {
  wayland.windowManager.hyprland = {
    plugins = [hyprbars];
    settings = {
      "plugin:hyprbars" = lib.mkForce {
        enabled = true;
        # Local colors
        bar_color = "rgba(504945dd)";
        "col.text" = "rgba(e78a4eff)";
        bar_height = 16;
        bar_text_font = "JetBrainsMono Nerd Font";
        bar_text_size = 12;
        bar_part_of_window = false;
        bar_precedence_over_border = false;
        hyprbars-button = let
          closeAction = "hyprctl dispatch killactive";

          isOnSpecial = ''hyprctl activewindow -j | jq -re 'select(.workspace.name == "special")' >/dev/null'';
          moveToSpecial = "hyprctl dispatch movetoworkspacesilent special";
          moveToActive = "hyprctl dispatch movetoworkspacesilent $(hyprctl -j activeworkspace | jq -re '.id')";
          minimizeAction = "${isOnSpecial} && ${moveToActive} || ${moveToSpecial}";

          maximizeAction = "hyprctl dispatch fullscreen 1";
        in [
          # Red close button
          "rgba(b91414ff),12,,${closeAction}"
          # Yellow "minimize" (send to special workspace) button
          "rgba(cb8d19ff),12,,${minimizeAction}"
          # Green "maximize" (fullscreen) button
          "rgba(85cb19ff),12,,${maximizeAction}"
        ];
      };

      windowrulev2 = [
        # Disable bars in floating pinned windows
        "plugin:hyprbars:nobar, floating:1, pinned:1"
        # Disable bars on floating image render on yazi
        "plugin:hyprbars:nobar, class:ueberzugpp.*"

        # Local focused colors (this host's colors)
        "plugin:hyprbars:bar_color rgba(e78a4eff), focus:1"
        "plugin:hyprbars:title_color rgba(504945ff), focus:1"
      ];
    };
  };
}
