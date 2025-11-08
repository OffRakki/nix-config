{ inputs, stylix, lib, config, pkgs, ... }: {

  imports = [
    ./hyprbars.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    settings = {
      "$mod"    = "SUPER";
      "$terminal"   = "${pkgs.alacritty}/bin/alacritty";
      "$files"      = "${pkgs.yazi}/bin/yazi";
      "$qalc" 			= "${pkgs.qalculate-gtk}/bin/qalculate-gtk";
      "$slurp" 			= "${pkgs.slurp}/bin/slurp";
      "$hyprshot"   = "${pkgs.hyprshot}/bin/hyprshot";

      monitor = [ 
        "DP-3,1920x1080@239.76,0x0,1"
        "HDMI-A-1,1920x1080@60,1920x0,1"
      ];

      workspace = [
        "1,monitor:DP-3"
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
        layout = "dwindle";
        border_size = 2;
        gaps_in = 4;
        gaps_out = 8;

        "col.active_border" = lib.mkForce "rgb(614821)";
        "col.inactive_border" = lib.mkForce "rgba(ddc7a1aa)";
      };

      input = {
        kb_layout = "us,us";
        kb_variant = "alt-intl,"; 
        kb_model = "";
        kb_options = "grp:alt_space_toggle";
        kb_rules = "";
        repeat_rate = 50;
        repeat_delay = 300;

        sensitivity = -0.8;
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
        disable_hyprland_logo = false;
        disable_splash_rendering = false;
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
        warp_on_change_workspace = 2;
        no_warps = true;
      };

      decoration = { 
        rounding = 8;

        active_opacity = 2.0;
        inactive_opacity = 0.95;
        fullscreen_opacity = 1.0;

        dim_inactive = true;
        dim_strength = 0.1;
        dim_special = 0.8;

        shadow = {
          enabled = false;
          range = 100;
          render_power = 4;
          #offset = "0 40";
          scale = 0.95;

          # "color" = "rgb(0,0,0)";
          # "color_inactive" = "rgb(0,0,0)";
        };

        blur = {
          enabled = true;
          size = 4;
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
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "linear, 0.0, 0.0, 1.0, 1.0"
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "slow, 0, 0.85, 0.3, 1"
          "overshot, 0.7, 0.6, 0.1, 1.1"
          "bounce, 1.1, 1.6, 0.1, 0.85"
          "sligshot, 1, -1, 0.15, 1.25"
          "nice, 0, 6.9, 0.5, -4.20"
        ];

        animation = [ 
          "windowsIn, 1, 6, slow, popin"
          "windowsOut, 1, 6, winOut, popin"
          "windowsMove, 1, 6, wind, slide"
          "border, 1, 6, linear"
          "borderangle, 1, 180, linear, loop" #used by rainbow borders and rotating colors
          "fade, 1, 6, overshot"
          "workspaces, 1, 6, wind"
          "windows, 1, 6, bounce, popin"
        ];
      };

      layerrule = ["blur, wofi"];

      windowrule = [
        "float, class:(middleFloat)"
        "size 50% 50%, class:(middleFloat)"
        "noblur, tag:games*"
        "opacity 2 2 2, class:google-chrome"
        "float, initialClass:chrome-nngceckbapebfimnlniiiahkandclblb-Default"
        "size 25% 50%, initialClass:chrome-nngceckbapebfimnlniiiahkandclblb-Default"
        "float, initialClass:Bitwarden"
        "size 25% 50%, initialClass:Bitwarden"
        "float, initialClass:org.pulseaudio.pavucontrol"
        "size 50% 50%, initialClass:org.pulseaudio.pavucontrol"
        "float, initialTitle:Open Folder"
        "size 25% 50%, initialTitle:Open Folder"
      ];
      
      windowrulev2 = ["idleinhibit fullscreen, class:.*"];

      env = [ 
        "NIXOS_OZONE_WL,1"
        "EDITOR,nvim #default editor"
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_QPA_PLATFORMTHEME,qt6ct   "
        "QT_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "QT_QUICK_CONTROLS_STYLE,org.hyprland.style"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "LIBVA_DRIVER_NAME,nvidia "
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct "
        "AQ_DRM_DEVICES,/dev/dri/card1"
        "WLR_DRM_DEVICES,/dev/dri/card1"
        "GBM_BACKEND,nvidia-drm "
        "__NV_PRIME_RENDER_OFFLOAD,1 "
        "__VK_LAYER_NV_optimus,NVIDIA_only"
        "WLR_DRM_NO_ATOMIC,1"
        "LIBGL_ALWAYS_SOFTWARE,1 # Warning. May cause hyprland to crash"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "MOZ_DISABLE_RDD_SANDBOX,1"
        "EGL_PLATFORM,wayland"
        "GDK_SCALE,1 "
        "MOZ_ENABLE_WAYLAND,1"
        "GTK_IM_MODULE=cedilla"
        "QT_IM_MODULE=cedilla"
        "UWSM_APP_UNIT_TYPE,service"
      ];

      exec-once = [ 
        "uwsm app -- syncthing --no-gui" 
        "uwsm app -- clipse -listen" # Clipboard history
        "uwsm app -- waybar"
        "uwsm app -- hyprpaper"
        "uwsm app -- swww-daemon --format xrgb"
        "uwsm app -- dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "uwsm app -- systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "uwsm app -- nm-applet --indicator"
        "uwsm app -- swaync"
        "uwsm app -- ags"
        "uwsm app -- blueman-applet"
        "uwsm app -- hypridle"
        "uwsm app -- pypr"
        #"swww img ${../../../hosts/rakki/wallpapers/aesthetic.png}"
        #"$scriptsDir/Polkit-NixOS.sh"
        "sleep 3 && uwsm app -- hyprlock"
        "sleep 2 && hyprctl dispatch workspace 1"
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
        ", Print, exec, $hyprshot -z --clipboard-only -m region"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
      ];

      bind = [ 
        "SHIFT, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%+"
        "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%-"
        "$mod, M, exec, loginctl terminate-user '' "
        "$mod, L, exec, uwsm app -- hyprlock"
        "$mod, D, exec, pkill wofi || uwsm app -- wofi --show drun -G --insensitive" #Main Menu
        "$mod ALT, D, exec, pkill wofi || uwsm app -- wofi --show run -G --insensitive" #Main Menu
        "$mod, V, exec, pkill clipse & uwsm app -- $terminal --class middleFloat -e clipse"
        "CTRL ALT, N, exec, uwsm app -- $terminal --class middleFloat -e nvim"
        "$mod, SPACE, togglefloating"
        "$mod, F, fullscreen, 1 # fake full screen"
        "$mod SHIFT, F, fullscreen"
        "$mod SHIFT, Q, killactive"
        "$mod, A, exec, pkill wofi || true && ags -t 'overview'"
        "$mod, Return, exec, uwsm app -- $terminal"  #terminal
        "$mod ALT, C, exec, pkill qalc & uwsm app -- $terminal --class middleFloat -e qalc" # calculator (qalculate)
        "$mod SHIFT, Return, exec, pypr toggle term" # Dropdown terminal
        "$mod, Z, exec, pypr zoom # Toggle Desktop Zoom"
        "$mod, E, exec, uwsm app -- $terminal -e $files"

        # Switch workspaces with mod + [0-9] 
        "$mod, 1, workspace, 1 # NOTE: code:10 = key 1"
        "$mod, 2, workspace, 2 # NOTE: code:11 = key 2"
        "$mod, 3, workspace, 3 # NOTE: code:12 = key 3"
        "$mod, 4, workspace, 4 # NOTE: code:13 = key 4"
        "$mod, 5, workspace, 5 # NOTE: code:14 = key 5"
        "$mod, 6, workspace, 6 # NOTE: code:15 = key 6"
        "$mod, 7, workspace, 7 # NOTE: code:16 = key 7"
        "$mod, 8, workspace, 8 # NOTE: code:17 = key 8"
        "$mod, 9, workspace, 9 # NOTE: code:18 = key 9"
        "$mod, 0, workspace, 10 # NOTE: code:19 = key 0"

        # Move active window and follow to workspace mod + SHIFT [0-9]
        "$mod SHIFT, code:10, movetoworkspace, 1 # NOTE: code:10 = key 1"
        "$mod SHIFT, code:11, movetoworkspace, 2 # NOTE: code:11 = key 2"
        "$mod SHIFT, code:12, movetoworkspace, 3 # NOTE: code:12 = key 3"
        "$mod SHIFT, code:13, movetoworkspace, 4 # NOTE: code:13 = key 4"
        "$mod SHIFT, code:14, movetoworkspace, 5 # NOTE: code:14 = key 5"
        "$mod SHIFT, code:15, movetoworkspace, 6 # NOTE: code:15 = key 6"
        "$mod SHIFT, code:16, movetoworkspace, 7 # NOTE: code:16 = key 7"
        "$mod SHIFT, code:17, movetoworkspace, 8 # NOTE: code:17 = key 8"
        "$mod SHIFT, code:18, movetoworkspace, 9 # NOTE: code:18 = key 9"
        "$mod SHIFT, code:19, movetoworkspace, 10 # NOTE: code:19 = key 0"
        "$mod SHIFT, bracketleft, movetoworkspace, -1 # brackets ["
        "$mod SHIFT, bracketright, movetoworkspace, +1 # brackets ]"


        # Move active window and do not follow to workspace mod + CTRL [0-9]
        "$mod CTRL, code:10, movetoworkspacesilent, 1 # NOTE: code:10 = key 1"
        "$mod CTRL, code:11, movetoworkspacesilent, 2 # NOTE: code:11 = key 2"
        "$mod CTRL, code:12, movetoworkspacesilent, 3 # NOTE: code:12 = key 3"
        "$mod CTRL, code:13, movetoworkspacesilent, 4 # NOTE: code:13 = key 4"
        "$mod CTRL, code:14, movetoworkspacesilent, 5 # NOTE: code:14 = key 5"
        "$mod CTRL, code:15, movetoworkspacesilent, 6 # NOTE: code:15 = key 6"
        "$mod CTRL, code:16, movetoworkspacesilent, 7 # NOTE: code:16 = key 7"
        "$mod CTRL, code:17, movetoworkspacesilent, 8 # NOTE: code:17 = key 8"
        "$mod CTRL, code:18, movetoworkspacesilent, 9 # NOTE: code:18 = key 9"
        "$mod CTRL, code:19, movetoworkspacesilent, 10 # NOTE: code:19 = key 0"

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
