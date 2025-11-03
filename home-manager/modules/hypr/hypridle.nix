{config, lib, ...}: {
  services.hypridle = {
    enable = true;
    settings = let
      isLocked = "pgrep hyprlock";
    in {
      general = {
        lock_cmd = "if ! ${isLocked}; then ${lib.getExe config.programs.hyprlock.package} --grace 5; fi";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
