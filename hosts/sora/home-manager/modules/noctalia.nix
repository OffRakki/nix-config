{
  pkgs,
  lib,
  ...
}: {
  home.persistence."/persist".directories = [
    ".cache/noctalia"
    ".cache/noctalia-qs"
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      shell = {
        ui_scale = 1;
        corner_radius_scale = 0.75;
        font_family = "sans-serif";
        font_weight = "bold";
        time_format = "{:%H:%M}";
        date_format = "%A, %x";
        offline_mode = false;
        telemetry_enabled = false;
        polkit_agent = true;
        password_style = "random";
        clipboard_enabled = true;
        clipboard_history_max_entries = 100;
        clipboard_auto_paste = "auto";
        shared_gl_context = true;
        avatar_path = "${../../../../assets/svgs/pelucio.jpg}";
        animation = {
          enabled = true;
          speed = 1;
        };
        shadow = {
          direction = "bottom_right";
          alpha = 0.55;
        };
        panel = {
          transparency_mode = "soft";
          borders = true;
          shadow = true;
          launcher_placement = "centered";
          clipboard_placement = "centered";
          control_center_placement = "floating";
          wallpaper_placement = "floating";
          session_placement = "floating";
        };
        mpris = {
          blacklist = [];
        };
      };

      wallpaper = {
        enabled = true;
        fill_mode = "crop";
        fill_color = "#000000";
        transition = ["fade" "wipe" "disc" "stripes" "zoom" "honeycomb"];
        transition_duration = 1500;
        edge_smoothness = 0.05;
        transition_on_startup = false;
        directory = "/home/rakki/Documents/NixConfig/assets/wallpapers";
        directory_light = "";
        directory_dark = "";
        default.path = "";
        automation = {
          enabled = false;
          interval_minutes = 5;
          order = "random";
          recursive = true;
        };
      };

      theme = {
        mode = "dark";
        source = "wallpaper";
        builtin = "m3_content";
        templates = {
          enable_builtin_templates = false;
          builtin_ids = [];
          enable_community_templates = false;
          community_ids = [];
        };
      };

      backdrop = {
        enabled = false;
        blur_intensity = 0.5;
        tint_intensity = 0.3;
      };

      notification = {
        enable_daemon = true;
        show_app_name = true;
        show_actions = true;
        position = "top_center";
        layer = "overlay";
        scale = 0.85;
        background_opacity = 0.9;
        offset_x = 10;
        offset_y = 2;
      };

      osd = {
        position = "top_right";
        orientation = "horizontal";
        scale = 1;
        background_opacity = 0.97;
        offset_x = 10;
        offset_y = 2;
        monitors = ["DP-1"];
        kinds = {
          volume = true;
          volume_output = true;
          volume_input = true;
          brightness = true;
          wifi = true;
          bluetooth = true;
          power_profile = true;
          caffeine = true;
          dnd = true;
          lock_keys = true;
          keyboard_layout = true;
        };
      };

      lockscreen = {
        enabled = true;
        blurred_desktop = true;
        blur_intensity = 0.8;
        tint_intensity = 0.1;
        monitors = ["DP-1"];
      };

      system = {
        monitor = {
          enabled = true;
          cpu_poll_seconds = 2;
          gpu_poll_seconds = 5;
          memory_poll_seconds = 2;
          network_poll_seconds = 3;
          disk_poll_seconds = 10;
        };
      };

      weather = {
        enabled = true;
        refresh_minutes = 30;
        unit = "celsius";
        effects = true;
      };

      audio = {
        enable_overdrive = true;
        enable_sounds = false;
        sound_volume = 0.5;
      };

      brightness = {
        enable_ddcutil = true;
      };

      nightlight = {
        enabled = false;
        force = false;
        temperature_day = 6500;
        temperature_night = 4000;
      };

      location = {
        auto_locate = false;
        address = "Piracicaba, Brazil";
      };

      idle = {
        pre_action_fade_seconds = 1;
        behavior = {
          lock = {
            timeout = 300;
            command = "noctalia:session lock";
            enabled = true;
          };
          screen-off = {
            timeout = 360;
            command = "noctalia:dpms-off";
            resume_command = "noctalia:dpms-on";
            enabled = true;
          };
        };
      };

      keybinds = {
        validate = ["return" "kp_enter"];
        cancel = ["escape"];
        left = ["left"];
        right = ["right"];
        up = ["up"];
        down = ["down"];
      };

      bar = {
        main = {
          position = "top";
          thickness = 32;
          background_opacity = 1;
          radius = 12;
          margin_h = 10;
          margin_v = 2;
          padding = 8;
          widget_spacing = 6;
          scale = 1;
          shadow = true;
          auto_hide = false;
          reserve_space = true;
          capsule = true;

          start = ["launcher" "CPU" "media" "active_window"];
          center = ["workspaces"];
          end = ["tray" "notifications" "bluetooth" "volume" "brightness" "clock" "session"];
        };
      };

      dock = {
        enabled = false;
        position = "bottom";
        icon_size = 48;
        background_opacity = 0.88;
        radius = 16;
        margin_h = 0;
        margin_v = 8;
        shadow = true;
        show_running = true;
        auto_hide = true;
        reserve_space = true;
        magnification = true;
        magnification_scale = 1.45;
        active_opacity = 1;
        inactive_opacity = 0.85;
        show_dots = false;
        show_instance_count = true;
        launcher_position = "none";
        launcher_icon = "grid-dots";
        active_monitor_only = true;
        pinned = [];
      };

      control_center = {
        shortcuts = [
          {type = "bluetooth";}
          {type = "wallpaper";}
          {type = "nightlight";}
          {type = "notification";}
          {type = "wifi";}
          {type = "session";}
        ];
      };

      hooks = {
        battery_low_percent_threshold = 0;
        session_locked = "touch /tmp/session.lock";
        session_unlocked = "rm -f /tmp/session.lock";
      };

      widget = {
        launcher = {
          position = "center";
          view_mode = "list";
          show_categories = true;
          icon_mode = "tabler";
          terminal_command = "kitty -e";
          sort_by_most_used = true;
          enable_settings_search = true;
          enable_windows_search = true;
          enable_session_search = true;
        };
        "control-center" = {
          dashboard_cards = [
            {
              id = "profile";
              enabled = true;
            }
            {
              id = "shortcuts";
              enabled = true;
            }
            {
              id = "audio";
              enabled = true;
            }
            {
              id = "brightness";
              enabled = false;
            }
            {
              id = "weather";
              enabled = true;
            }
            {
              id = "media-sysmon";
              enabled = true;
            }
          ];
        };
        clock = {
          format = "{:%H:%M}";
          tooltip_format = "{:%A, %B %d, %Y}";
          scale = 1;
        };
      };
    };
  };
}
