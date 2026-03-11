{...}: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      # Display
      legacy_layout = true;
      hud_position = "top-left";
      hud_compact = true;
      background_alpha = 0.2;
      font_size = 24;

      # Process info
      proc_mem = true; # RAM used by the game specifically
      io_read = true; # disk read/write of the game process
      io_write = true;

      # GPU
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      gpu_fan = true;
      gpu_voltage = true;
      throttling_status = true;

      # CPU
      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_mhz = true;

      # Memory
      ram = true;
      vram = true;

      # FPS
      fps = true;
      fps_limit = "237,120,0"; # 0 = unlimited
      frametime = true;
      frame_timing = true;

      # Other info
      gamepad_battery = true;
      battery = true;
      time = true;
      time_format = "%H:%M";

      # Thresholds for color changes
      cpu_load_change = true;
      cpu_load_value = "50,90"; # yellow, red thresholds
      cpu_load_color = "39f900,ffaa00,ff0000";

      gpu_load_change = true;
      gpu_load_value = "50,90";
      gpu_load_color = "39f900,ffaa00,ff0000";

      fps_color_change = true;
      fps_value = "60,237"; # red below 30, yellow 30-60, green above 60
      fps_color = "ff0000,ffaa00,39f900";
    };
  };
}
