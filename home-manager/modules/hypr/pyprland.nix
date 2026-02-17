{ pkgs, ...}:
let
  term = "kitty";
  term_classed = "${term} --class";
in{
  xdg.enable = true;
  
  xdg.configFile."hypr/pyprland.toml".source = (pkgs.formats.toml { }).generate "pyprland-config" {
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
        command = "${term_classed} ${term}-dropterm";
        class = "${term}-dropterm";
        size = "75% 60%";
        max_size = "1920px 100%";
        unfocus = "hide";
        preserve_aspect = true;
      };
      volume = {
        animation = "fromRight";
        command = "pavucontrol";
        class = "org.pulseaudio.pavucontrol";
        lazy = "true";
        size = "40% 90%";
        max_size = "1080px 100%";
        unfocus = "hide";
        preserve_aspect = true;
      };
    };
  };
}
