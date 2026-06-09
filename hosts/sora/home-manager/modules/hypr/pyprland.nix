{pkgs, ...}: let
  term = "kitty";
  topMargin = 40;
  bottomMargin = 0;
in {
  xdg.enable = true;
  xdg.configFile."pypr/config.toml".source = (pkgs.formats.toml {}).generate "pyprland-config" {
    pyprland.plugins = [
      "scratchpads"
      "toggle_special"
      "lost_windows"
      "toggle_special"
      "shift_monitors"
      "toggle_dpms"
      "magnify"
      "expose"
      "shift_monitors"
      "workspaces_follow_focus"
      "fetch_client_menu"
    ];

    scratchpads = {
      term = {
        animation = "fromTop";
        command = "${term} --class pypr-${term}";
        class = "pypr-${term}";
        size = "75% 60%";
        max_size = "1920px 100%";
        margin = topMargin;
        unfocus = "hide";
        preserve_aspect = true;
      };
      volume = {
        animation = "fromTop";
        command = "pwvucontrol";
        class = "com.saivert.pwvucontrol";
        lazy = "true";
        size = "75% 60%";
        max_size = "1920px 100%";
        margin = topMargin;
        unfocus = "hide";
        preserve_aspect = true;
      };
      spotify = {
        animation = "fromBottom";
        command = "spotify";
        class = "spotify";
        lazy = "false";
        size = "70% 40%";
        max_size = "1920px 100%";
        margin = bottomMargin;
        unfocus = "hide";
        preserve_aspect = true;
      };
    };
  };
}
