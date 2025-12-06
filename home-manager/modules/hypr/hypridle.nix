{config, lib, ...}: {
  services.hypridle = {
    enable = true;
    settings = let
      isLocked = "pgrep hyprlock";
    in {
      general = {
        lock_cmd = "if ! ${isLocked}; then hyprlock --grace 5; fi";
        inhibit_sleep = 3;
        after_sleep_cmd = "niri msg output DP-1 on && niri msg output HDMI-A-1 on";
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "if ! ${isLocked}; then hyprlock --grace 5; fi";
        }
        # If already locked
        {
          timeout = 720;
          on-timeout = "if ${isLocked}; then niri msg output DP-1 off && niri msg output HDMI-A-1 off; fi";
          on-resume = "niri msg output DP-1 on && niri msg output HDMI-A-1 on";
        }
      ];
    };
  };
}
