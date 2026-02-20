{ inputs, lib, config, pkgs, ... }: let

  swayosd = {
    output-volume = "swayosd-client --output-volume +0";
    input-volume = "swayosd-client --input-volume +0";
    caps-lock = "sleep 0.2 && swayosd-client --caps-lock";
  };

in {

  imports = [
    # ./hyprbars.nix
    # ./hyprscrolling.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    settings = {
      "$mod"        = "SUPER";
      "$terminal"   = "${lib.getExe pkgs.kitty}";
      "$files"      = "${lib.getExe pkgs.yazi}";
      "$filesGUI"   = "${lib.getExe pkgs.lxqt.pcmanfm-qt}";
      "$qalc" 			= "${lib.getExe pkgs.qalculate-gtk}";
      "$slurp" 			= "${lib.getExe pkgs.slurp}";
      "$hyprshot"   = "${lib.getExe pkgs.hyprshot}";
      "$lock"       = "caelestia shell lock lock";

      monitorv2 = [
        {
          output = "DP-1";
          mode = "1920x1080@239.76";
          position = "0x0";
          scale = 1;
          # addreserved = "30,0,0,0";
        } 
        {
          output = "HDMI-A-1";
          mode = "1920x1080@60";
          position = "-1920x0";
          scale = 1;
          # addreserved = "30,0,0,0";
        } 
      ];

      workspace = [
        "name:Browser,monitor:DP-1,persistent:true,default:true"
        "name:Social,monitor:HDMI-A-1,persistent:true,default:true"
        "name:Games,monitor:DP-1,persistent:true"
        "name:Extra,monitor:DP-1,persistent:true"
      ];

      dwindle = {	
        pseudotile = "yes";
        preserve_split = "yes";
        special_scale_factor = 0.8;
      };

      master = {
        new_status = "slave";	
        new_on_top = true;
        orientation = "right";
        mfact = 0.5;
      };

      general = {
        resize_on_border = true;
        allow_tearing = false;
        layout = "scrolling";
        border_size = 2;
        gaps_in = 4;
        gaps_out = 4;

        "col.active_border" = "rgba(BFA16Eff)";
        "col.inactive_border" = "rgba(BFA16E44)";
      };

      input = {
        kb_layout = "us,us";
        kb_variant = "alt-intl,"; 
        kb_model = "";
        kb_options = "grp:alt_space_toggle";
        kb_rules = "";
        repeat_rate = 50;
        repeat_delay = 300;

        sensitivity = -0.9;
        numlock_by_default = true;
        left_handed = false;
        follow_mouse = true;
        float_switch_override_focus = true;
        tablet = {
          transform = 0;
          left_handed = 0;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = false;
        vrr = 2;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        focus_on_activate = false;
        initial_workspace_tracking = 1;
        middle_click_paste = false;
      };

      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
        pass_mouse_when_bound = true;
      };

      cursor = {
        no_hardware_cursors = true;
        enable_hyprcursor = true;
        warp_on_change_workspace = 1;
        no_warps = true;
      };

      decoration = { 
        rounding = 12;

        active_opacity = 1.0;
        inactive_opacity = 0.90;
        fullscreen_opacity = 1.0;

        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0.8;

        shadow = {
          enabled = false;
          range = 1;
          render_power = 1;
          offset = "2.5 5";
          scale = 1;

          color = "rgba(00000044)";
          color_inactive = "rgba(00000022)";
        };

        blur = {
          enabled = true;
          size = 2;
          passes = 4;
          ignore_opacity = true;
          new_optimizations = true;
          special = true;
          popups = true;
        };
      };

      animations = {
        enabled = "yes, please :)";

        bezier = [ 
          "easeout,0.5, 1, 0.9, 1"
          "easeoutback,0.34,1.22,0.65,1"
        ];

        animation = [ 
          "fadeIn,1,3,easeout"
          "fadeLayersIn,1,3,easeout"
          "fadeOut,1,3,easeout"
          "fadeLayersOut,1,3,easeout"
          "fadeSwitch,1,2,easeout"
          "fadeDim,1,3,easeout"
          "fadeShadow,1,2,easeout"
          "border,1,2,easeout"

          "layersIn,1,3,easeoutback,slide"
          "layersOut,1,3,easeoutback,slide"

          "windowsOut,1,3,easeout,slide"
          "windowsMove,1,3,easeoutback"
          "windowsIn,1,3,easeoutback,slide"

          "workspaces,1,2.5,easeoutback,slidefade"
        ];
      };

      layerrule = [
        {
          name = "wofi";
          "match:namespace" = "wofi";
          blur = "on";
          
        }
        {
          name = "swayosd";
          "match:namespace" = "swayosd";
          above_lock = 2;
          
        }
        {
          name = "";
          "match:namespace" = "waybar";
          blur = "on";
          ignore_alpha = 1;
          # animation = "slide";
          
        }
        {
          name = "";
          "match:namespace" = "notifications";
          blur = "on";
          ignore_alpha = 1;
          
        }
        {
          name = "hyprpicker";
          "match:namespace" = "hyprpicker";
          animation = "fade";
          
        }
        {
          name = "selection";
          "match:namespace" = "selection";
          animation = "fade";
          
        }
        {
          name = "hyprpaper";
          "match:namespace" = "hyprpaper";
          animation = "fade";
          
        }
      ];

      windowrule = [
        # fix for brave border color not being displayed correctly.
        {
          name = "braveBorderColorFix";
          "match:class" = "brave-browser";
          border_color = "rgba(5c4826ff) rgba(5c482644)";
        }
        {
          name = "middleFloatClass";
          "match:class" = "middleFloat";
          float = "on";
          size = "monitor_w/2 monitor_h/2";
        }
        {
          name = "waypaper";
          "match:initial_class" = "waypaper";
          float = "on";
          size = "monitor_w/2 monitor_h/2";
        }
        {
          name = "prismLauncher";
          "match:initial_class" = "org.prismlauncher.PrismLauncher";
          no_initial_focus = "on";
          workspace = "Extra";
          monitor = "DP-1";
        }
        {
          name = "steamClient";
          "match:initial_class" = "steam";
          no_initial_focus = "on";
          tile = "on";
          workspace = "Extra";
          monitor = "DP-1";
        }
        {
          name = "minceraft";
          "match:initial_title" = "Minecraft.*";
          no_blur = "on";
          no_initial_focus = "on";
          tile = "on";
          workspace = "Games";
          monitor = "DP-1";
        }
        {
          name = "steamGames";
          "match:initial_class" = "steam_app.*";
          no_blur = "on";
          no_initial_focus = "on";
          tile = "on";
          workspace = "Games";
          monitor = "DP-1";
        }
        {
          name = "telegram";
          "match:initial_class" = "org.telegram.desktop";
          no_initial_focus = "on";
          workspace = "Social";
          monitor = "HDMI-A-1";
        }
        {
          name = "goofcord";
          "match:initial_class" = "goofcord";
          no_initial_focus = "on";
          workspace = "Social";
          monitor = "HDMI-A-1";
        }
        {
          name = "whatsapp";
          "match:initial_title" = "web.whatsapp.com.*";
          no_initial_focus = "on";
          workspace = "Social";
          monitor = "HDMI-A-1";
        }
        {
          name = "browser";
          "match:class" = "brave-browser";
          opacity = "2 2 2";
          workspace = "Browser";
          monitor = "DP-1";
        }
        {
          name = "bitwardenBrowser";
          "match:initial_class" = "brave-nngceckbapebfimnlniiiahkandclblb-Default";
          float = "on";
          size = "window_w/2 window_h/2";
        }
        {
          name = "pavucontrol";
          "match:initial_class" = "org.pulseaudio.pavucontrol";
          float = "on";
          size = "window_w/2 window_h/2";
        }
        {
          name = "folderSelector";
          "match:initial_title" = "Open Folder";
          float = "on";
          size = "window_w/4 window_h/2";
        }
        {
          name = "bluetooth";
          "match:initial_title" = "Bluetooth Devices";
          float = "on";
          size = "window_w/4 window_h/2";
        }
        {
          name = "idle_inhibitFullscreen";
          "match:class" = "brave-browser"; #Change to ".*" if want to apply to any fullscreen application
          idle_inhibit = "fullscreen";
        }
        {
          name = "sshColorTmpst";
          "match:title" = ".*/home/deby.*";
          border_color = "rgba(7287fdff) rgba(7287fdaa)";
        }
      ];
      

      env = [ 
        "AQ_DRM_DEVICES,/dev/dri/card1"
        "CLUTTER_BACKEND,wayland"
        "EDITOR,hx" #default editor
        "EGL_PLATFORM,wayland"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "GBM_BACKEND,nvidia-drm "
        "GDK_BACKEND,wayland,x11"
        "GDK_SCALE,1 "
        "LIBVA_DRIVER_NAME,nvidia "
        "MOZ_DISABLE_RDD_SANDBOX,1"
        "MOZ_ENABLE_WAYLAND,1"
        "NVD_BACKEND,direct "
        "UWSM_APP_UNIT_TYPE,service"
        "WLR_DRM_DEVICES,/dev/dri/card1"
        "WLR_DRM_NO_ATOMIC,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "__NV_PRIME_RENDER_OFFLOAD,1 "
        "__VK_LAYER_NV_optimus,NVIDIA_only"
      ];

      exec-once = [ 
        "clipse -listen" # Clipboard history
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "nm-applet --indicator"
        "ags"
        "blueman-applet"
        "pypr"
        "vicinae server"
        "swww-daemon"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "sleep 3 && systemctl --user restart clip-notify"
        "steam"
        "Telegram"
        "prismlauncher"
        "goofcord"
        "brave --profile-directory=Default --app=https://web.whatsapp.com"
      ];

      binde = [
        "$mod CTRL, left, resizeactive,-50 0"
        "$mod CTRL, right, resizeactive,50 0"
        "$mod CTRL, up, resizeactive,0 -50"
        "$mod CTRL, down, resizeactive,0 50"
      ];

      bindr = [ 
      ];

      bindn = [ 
      ];

      bindm = [
        "$mod, mouse:272, movewindow # NOTE: mouse:272 = left click"
        "$mod, mouse:273, resizewindow # NOTE: mouse:272 = right click"
      ];

      bindl = [ 
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" #; ${swayosd.output-volume}"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"#; ${swayosd.output-volume}"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"#; ${swayosd.output-volume}"
        "SHIFT, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"#; ${swayosd.input-volume}"
        "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"#; ${swayosd.input-volume}"
        "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"#; ${swayosd.input-volume}"
        # ",Caps_Lock,exec,${swayosd.caps-lock}"
      ];

      bind = [ 
        # pypr
        "$mod SHIFT, Return, exec, pypr toggle term" # Dropdown terminal
        "$mod SHIFT, V, exec, pypr toggle volume" # Pavucontrol

        "$mod, F2, exec, caelestia toggle music"

        
        "CTRL ALT, N, exec, $terminal --class middleFloat -e hx"
        "$mod SHIFT, P, exec,  '${config.customPaths.scriptsDir}/pass-wofi.sh'"
        "$mod SHIFT, W, exec, waypaper"
        "$mod,g,togglegroup"
        "$mod,i,pin"
        ", Print, exec, caelestia shell picker openFreezeClip"
        "CTRL, Print, exec, $hyprshot -z --clipboard-only -m output --freeze"
        "$mod, L, exec, $lock"
        # "$mod, D, exec, pkill wofi || wofi --show drun -G --insensitive" #Main Menu
        "$mod, D, exec, caelestia shell drawers toggle launcher"
        "$mod SHIFT, D, exec, vicinae open"
        "$mod, K, exec, caelestia shell drawers toggle sidebar"
        "$mod SHIFT, K, exec, caelestia toggle music"
        "$mod ALT, D, exec, pkill wofi || wofi --show run -G --insensitive" #Main Menu
        "$mod, V, exec, pkill clipse & $terminal --class middleFloat -e clipse"
        "$mod, SPACE, togglefloating"
        "$mod, F, fullscreen, 1" # fake full screen 
        "$mod SHIFT, F, fullscreen"
        "$mod SHIFT, Q, killactive"
        "$mod, A, exec, pkill wofi || true && ags -t 'overview'"
        "$mod, Return, exec, $terminal"  #terminal
        "$mod ALT, C, exec, pkill qalc & $terminal --class middleFloat -e qalc" # calculator (qalculate)
        "$mod, Z, exec, pypr zoom" # Toggle Desktop Zoom
        "$mod, E, exec, $filesGUI"
        "$mod SHIFT, E, exec, $terminal -e $files"

        # Switch workspaces with mod + [0-9] 
        "$mod, 1, workspace, Browser"
        "$mod, 2, workspace, Social"
        "$mod, 3, workspace, Games"
        "$mod, 4, workspace, Extra"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window and follow to workspace mod + SHIFT [0-9]
        "$mod SHIFT, 1, movetoworkspace, Browser"
        "$mod SHIFT, 2, movetoworkspace, Social"
        "$mod SHIFT, 3, movetoworkspace, Games"
        "$mod SHIFT, 4, movetoworkspace, Extra"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod SHIFT, bracketleft, movetoworkspace, -1 # brackets ["
        "$mod SHIFT, bracketright, movetoworkspace, +1 # brackets ]"


        # Move active window and do not follow to workspace mod + CTRL [0-9]
        "$mod CTRL, 1, movetoworkspacesilent, Browser"
        "$mod CTRL, 2, movetoworkspacesilent, Social"
        "$mod CTRL, 3, movetoworkspacesilent, Games"
        "$mod CTRL, 4, movetoworkspacesilent, extra"
        "$mod CTRL, 5, movetoworkspacesilent, 5"
        "$mod CTRL, 6, movetoworkspacesilent, 6"
        "$mod CTRL, 7, movetoworkspacesilent, 7"
        "$mod CTRL, 8, movetoworkspacesilent, 8"
        "$mod CTRL, 9, movetoworkspacesilent, 9"
        "$mod CTRL, 0, movetoworkspacesilent, 10"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Dwindle Layout
        "$mod SHIFT, I, togglesplit # only works on dwindle layout"
        "$mod, P, pseudo, # dwindle"
      ];

      # For passthrough keyboard into a VM
      # bind = $modALT, P, submap, passthru
      #submap = passthru
      # to unbind
      #bind = $modALT, P, submap, reset
      #submap = reset
    };
  };
}
