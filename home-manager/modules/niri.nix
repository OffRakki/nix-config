{config, lib, pkgs, ...}: {
  programs.niri = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    settings = {
      "$mod"        = "SUPER";
      "$terminal"   = "${lib.getExe pkgs.alacritty}";
      "$files"      = "${lib.getExe pkgs.yazi}";
      "$filesGUI"   = "${lib.getExe' pkgs.kdePackages.dolphin "dolphin"}";
      "$qalc" 			= "${lib.getExe pkgs.qalculate-gtk}";
      "$slurp" 			= "${lib.getExe pkgs.slurp}";
      "$hyprshot"   = "${lib.getExe pkgs.hyprshot}";


      input = {
        repeat_rate = 50;
        repeat_delay = 300;
        sensitivity = -0.8;

        bind = [
        "$mod, D, exec, uwsm app -- vicinae open" #Main Menu
        "$mod, Return, exec, $terminal"
        ];
      };
    };
  };
}
