{config, pkgs, lib, ...}: {
  services.hypridle = {
    enable = true;
    settings = let
      locker = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
    in {
      general = {
        lock_cmd = "caelestia shell lock lock";
        inhibit_sleep = 3;
        before_sleep_cmd = "${locker}";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${locker}";
        }
        {
          timeout = 720;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
