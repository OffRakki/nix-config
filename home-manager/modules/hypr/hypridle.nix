{config, lib, ...}: {
  services.hypridle = {
    enable = true;
    settings = let
      isLocked = "pgrep hyprlock";
    in {
      general = {
        lock_cmd = "if ! ${isLocked}; then ${lib.getExe config.programs.hyprlock.package} --grace 5; fi";
        inhibit_sleep = 3;
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # If already locked
        {
          timeout = 30;
          on-timeout = "if ${isLocked}; then hyprctl dispatch dpms off; fi";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
