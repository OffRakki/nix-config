{config, lib, pkgs, inputs, ...}:
let  
  swayosd = {
    output-volume = "swayosd-client --output-volume +0";
    input-volume = "swayosd-client --input-volume +0";
    caps-lock = "sleep 0.2 && swayosd-client --caps-lock";
  };
  terminal = "${lib.getExe pkgs.alacritty}";
  files    = "${lib.getExe pkgs.yazi}";
  filesGUI = "${lib.getExe pkgs.xfce.thunar}";
  qalc 		 = "${lib.getExe pkgs.qalculate-gtk}";
  slurp 	 = "${lib.getExe pkgs.slurp}";
  hyprshot = "${lib.getExe pkgs.hyprshot}";
in
{
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
    settings = {
      xwayland-satellite.enable = true;
      environment = {
        XCURSOR_THEME = "Catppuccin-Mocha-Peach";
        XCURSOR_SIZE = "24";
        AQ_DRM_DEVICES = "/dev/dri/card1";
        CLUTTER_BACKEND = "wayland";
        EDITOR = "hx";
        EGL_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        GBM_BACKEND = "nvidia-drm ";
        GDK_BACKEND = "wayland,x11";
        GDK_SCALE = "1";
        LIBVA_DRIVER_NAME = "nvidia";
        MOZ_DISABLE_RDD_SANDBOX = "1";
        MOZ_ENABLE_WAYLAND = "1";
        NVD_BACKEND = "direct";
        WLR_DRM_DEVICES = "/dev/dri/card1";
        WLR_DRM_NO_ATOMIC = "1";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
      };

      outputs = {
        DP-1 = {
          mode = {
            height = 1080;
            width = 1920;
            refresh = 239.760;
          };
          position = {
            x = 1920;
            y = 0;
          };
          variable-refresh-rate = "on-demand";
          focus-at-startup = true;
          backdrop-color = "#1e1e2e";
        };
        HDMI-A-1 = {
          mode = {
            height = 1080;
            width = 1920;
            refresh = 60.00;
          };
          position = {
            x = 0;
            y = 0;
          };
          backdrop-color = "#1e1e2e";
        };
      };

      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;

      spawn-at-startup = [
        { sh = "syncthing --no-gui"; }
        { argv = [ "clipse" "-listen" ]; }
        { argv = [ "vicinae" "server" ]; }
        { argv = [ "xwayland-satellite" ]; }
        { sh = "sleep 3 && systemctl --user restart clip-notify"; }
        { sh = "sleep 3 && swww-daemon"; }
        # for steam to work (don't know why)
        { sh = "dbus-update-activation-environment systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; }
        { sh = "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; }
      ];

      input = {
        mod-key = "SUPER";
        mouse = {
          enable = true;
          accel-speed = -0.8;
          natural-scroll = false;
        };
        focus-follows-mouse.enable = false;
        keyboard = {
          numlock = true;
          repeat-delay = 300;
          repeat-rate = 50;
          xkb = {
            layout = "us";
            variant = "alt-intl";
            options = "grp:alt_space_toggle";
            rules = "";
            model = "pc105";
          }; 
          track-layout = "global";
        };
        power-key-handling.enable = false;
      };

      layout = {
        always-center-single-column = true;
        default-column-width.proportion = 0.5;
        # drawn around the window (outside)
        focus-ring = {
          enable = false;
          width = 2;
          active.color = "#f9e2af";
          inactive.color = "#b4befe";
          urgent.color = "#f38ba8";
        };
        # drawn inside the window
        border = {
          enable = true;
          width = 2;
          active.color = "#f9e2af";
          inactive.color = "#b4befe";
          urgent.color = "#f38ba8";
        };
        gaps = 8;
        struts = {
          top = 36;
          right = 4;
          bottom = 4;
          left = 4;
        };
        shadow = {
          enable = true;
          draw-behind-window = true;
          color = "#00000070";
          inactive-color = "#00000070";
          # offset = {
          #   x = "";
          #   y = "";
          # };
          softness = 30;
          spread = 5;
        };
      };

      window-rules = [
        # styling
        {
          matches = [
            { title = ".*"; }
          ];
          geometry-corner-radius = {
            top-left = 6.0;
            top-right = 6.0;
            bottom-right = 6.0;
            bottom-left = 6.0;
          };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
        {
          matches = [
            { app-id = ".*"; is-focused = true; }
          ];
          excludes = [
            { app-id = "google-chrome"; }
            { app-id = "org.qutebrowser.qutebrowser"; }
            { app-id = "brave-browser"; }
          ];
          opacity = 0.98;
        }
        {
          matches = [
            { app-id = ".*"; is-focused = false; }
          ];
          excludes = [
            { app-id = "google-chrome"; }
            { app-id = "org.qutebrowser.qutebrowser"; }
            { app-id = "brave-browser"; }
          ];
          opacity = 0.9;
        }
        # floating windows
        {
          matches = [
            { app-id = "floatclass"; }
            { app-id = "waypaper"; }
            { app-id = "chrome-nngceckbapebfimnlniiiahkandclblb-Default"; }
            { app-id  = ".*Bitwarden.*"; }
            { app-id  = "org.pulseaudio.pavucontrol"; }
          ];
          open-floating = true;
        }
        {
          matches = [
            { title = ".*/home/deby.*"; }
          ];
          border = {
            active.color = "#00FFFF";
            inactive.color = "#5D8AA8";
          };
        }
      ];

      binds = with config.lib.niri.actions; {
      "Mod+Escape" = {
        allow-inhibiting = false;
        action = toggle-keyboard-shortcuts-inhibit;
      };
      "Mod+Return".action.spawn = terminal;
      "Mod+Shift+M".action.spawn-sh = ["niri msg action quit"];
      "Mod+D".action.spawn = [ "vicinae" "open" ]; #Main Menu
      "Mod+Shift+W".action.spawn = [ "waypaper" ];
      # "Mod+D".action.spawn-sh = [ "wofi -S drun -W 14% -H 40%" ];
      "Mod+Shift+Q" = {
        action = close-window;
        cooldown-ms = 150;
      };
      "Mod+W".action.spawn = filesGUI;
      "Mod+L".action.spawn = "hyprlock";
      "Mod+O".action = toggle-overview;
      "Mod+V".action.spawn-sh = [ "pkill clipse; ${terminal} --class floatclass --title clipse -e clipse" ];
      "Mod+Shift+P".action.spawn = [ "${config.scriptsDir}/pass-wofi.sh" ];
      "Mod+Alt+C".action.spawn-sh = [ "pkill qalc; ${terminal} --class floatclass --title qalc -e qalc" ];
      "Ctrl+Alt+N".action.spawn-sh = [ "${terminal} --class middleFloat -e hx" ];

      "XF86AudioMute" = {
        action.spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; ${swayosd.output-volume}" ];
        allow-when-locked = true;
      };
      "XF86AudioRaiseVolume" = {
      action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; ${swayosd.output-volume}" ];
      allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
      action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; ${swayosd.output-volume}" ];
      allow-when-locked = true;
      };
      "Shift+XF86AudioMute" = {
        action.spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle; ${swayosd.input-volume}" ];
        allow-when-locked = true;
      };
      "Shift+XF86AudioRaiseVolume" = {
        action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+; ${swayosd.input-volume}" ];
        allow-when-locked = true;
      };
      "Shift+XF86AudioLowerVolume" = {
        action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-; ${swayosd.input-volume}" ];
        allow-when-locked = true;
      };
      "Caps_Lock" = {
        action.spawn-sh = [ "${swayosd.caps-lock}" ];
        allow-when-locked = true;
      };

      # printscreen
      "Print".action.spawn-sh = [ "${hyprshot} -z --clipboard-only -m region --freeze" ];
      "Shift+Print".action.spawn-sh = [ "${hyprshot} -z --clipboard-only -m window --freeze" ];
      "Ctrl+Print".action.spawn-sh = [ "${hyprshot} -z --clipboard-only -m output --freeze" ];

      # window
      "Mod+Space".action = toggle-window-floating;
      "Mod+Shift+Space".action = switch-focus-between-floating-and-tiling;
      
      "Mod+left".action = focus-column-left;
      "Mod+h".action = focus-column-left;
      "Mod+right".action = focus-column-right;
      "Mod+i".action = focus-column-right;
      "Mod+up".action = focus-window-up;
      "Mod+e".action = focus-window-up;
      "Mod+down".action = focus-window-down;
      "Mod+a".action = focus-window-down;
      "Mod+Shift+WheelScrollUp".action = focus-column-left;
      "Mod+Shift+WheelScrollDown".action = focus-column-right;

      "Mod+Shift+left".action = move-column-left;
      "Mod+Shift+h".action = move-column-left;
      "Mod+Shift+right".action = move-column-right;
      "Mod+Shift+i".action = move-column-right;
      "Mod+Shift+up".action = move-window-up;
      "Mod+Shift+e".action = move-window-up;
      "Mod+Shift+down".action = move-window-down;
      "Mod+Shift+a".action = move-window-down;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";

      # You can refer to workspaces by index. However, keep in mind that
      # niri is a dynamic workspace system, so these commands are kind of
      # "best effort". Trying to refer to a workspace index bigger than
      # the current workspace count will instead refer to the bottommost
      # (empty) workspace.
      # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
      # will all refer to the 3rd workspace.
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action =move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;
      
      "Mod+Ctrl+left".action = focus-monitor-left;
      "Mod+Ctrl+h".action = focus-monitor-left;
      "Mod+Ctrl+right".action = focus-monitor-right;
      "Mod+Ctrl+i".action = focus-monitor-right;
      "Mod+Ctrl+up".action = focus-workspace-up;
      "Mod+Ctrl+e".action = focus-workspace-up;
      "Mod+Ctrl+down".action = focus-workspace-down;
      "Mod+Ctrl+a".action = focus-workspace-down;

      "Mod+Ctrl+Shift+left".action = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+h".action = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+right".action = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+i".action = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+up".action = move-column-to-workspace-up;
      "Mod+Ctrl+Shift+e".action = move-column-to-workspace-up;
      "Mod+Ctrl+Shift+down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Shift+a".action = move-column-to-workspace-down;

      "Mod+Alt+left".action = move-workspace-to-monitor-left;
      "Mod+Alt+h".action = move-workspace-to-monitor-left;
      "Mod+Alt+right".action = move-workspace-to-monitor-right;
      "Mod+Alt+i".action = move-workspace-to-monitor-right;

      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;
      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+C".action = center-column;
      "Mod+Ctrl+C".action = center-visible-columns;
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;
      
      # workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Page_up".action = focus-workspace-up;
      "Mod+Page_down".action = focus-workspace-down;
      "Mod+WheelScrollUp".action = focus-workspace-up;
      "Mod+WheelScrollDown".action = focus-workspace-down;
      };
    };
  };
}
