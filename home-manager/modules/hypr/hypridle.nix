{config, lib, pkgs, ...}:
{
  services.hypridle = {
    enable = true;
    settings = let
      isLocked = "pgrep hyprlock";
    in {
      general = {
        lock_cmd = "if ! ${isLocked}; then hyprlock --grace 5; fi";
        inhibit_sleep = 3;
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "if ! ${isLocked}; then hyprlock --grace 5; fi";
        }
        # If already locked
        {
          timeout = 720;
          on-timeout = "if ${isLocked}; then hyprctl dispatch dpms off; fi";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };      # (lib.optionals config.programs.niri.enable {
      #   general = {
      #     lock_cmd = "if ! ${isLocked}; then hyprlock --grace 5; fi";
      #     inhibit_sleep = 3;
      #     after_sleep_cmd = "niri msg output DP-3 on";
      #   };
      #   listener = [
      #     {
      #       timeout = 120;
      #       on-timeout = "if ! ${isLocked}; then hyprlock --grace 5; fi";
      #     }
      #     # If already locked
      #     {
      #       timeout = 720;
      #       on-timeout = "if ${isLocked}; then niri msg output DP-3 off; fi";
      #       on-resume = "niri msg output DP-3 on";
      #     }
      #   ];
      # })
      # ++
      # (lib.optionals config.wayland.windowManager.hyprland.enable {
      #   general = {
      #     lock_cmd = "if ! ${isLocked}; then hyprlock --grace 5; fi";
      #     inhibit_sleep = 3;
      #     after_sleep_cmd = "hyprctl dispatch dpms on";
      #   };
      #   listener = [
      #     {
      #       timeout = 120;
      #       on-timeout = "if ! ${isLocked}; then hyprlock --grace 5; fi";
      #     }
      #     # If already locked
      #     {
      #       timeout = 720;
      #       on-timeout = "if ${isLocked}; then hyprctl dispatch dpms off; fi";
      #       on-resume = "hyprctl dispatch dpms on";
      #     }
      #   ];
      # });
  };
}
