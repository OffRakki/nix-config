{ inputs,lib, config, pkgs, ... }: let

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
      "$filesGUI"   = "${lib.getExe pkgs.xfce.thunar}";
      "$qalc" 			= "${lib.getExe pkgs.qalculate-gtk}";
      "$slurp" 			= "${lib.getExe pkgs.slurp}";
      "$hyprshot"   = "${lib.getExe pkgs.hyprshot}";

      monitor = [ 
        "DP-1,1920x1080@239.76,1920x0,1"
        "HDMI-A-1,1920x1080@60,0x0,1"

        ",addreserved,36,0,0,0"
      ];

      workspace = [
        "1,monitor:DP-1,persistent:true"
        "2,monitor:HDMI-A-1,persistent:true"
        "3,monitor:DP-1,persistent:true"
        "4,monitor:HDMI-A-1,persistent:true"
        "5,monitor:DP-1,persistent:true"
        "6,monitor:HDMI-A-1,persistent:true"
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
        border_size = 1;
        gaps_in = 4;
        gaps_out = 8;

        "col.active_border" = lib.mkForce "rgba(e78a4eff)";
        "col.inactive_border" = lib.mkForce "rgba(141617dd)";
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
        rounding = 6;

        active_opacity = 1.0;
        inactive_opacity = 0.90;
        fullscreen_opacity = 1.0;

        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0.8;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 4;
          # offset = "0 40";
          scale = 0.95;

          # "color" = "rgb(0,0,0)";
          # "color_inactive" = "rgb(0,0,0)";
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
        "blur, wofi"
        "abovelock,swayosd"

        "animation fade,hyprpicker"
        "animation fade,selection"
        "animation fade,hyprpaper"

        "animation slide,waybar"
        "blur,waybar"
        "ignorezero,waybar"

        "blur,notifications"
        "ignorezero,notifications"

        "blur,wofi"
        "ignorezero,wofi"

        "noanim,wallpaper"

        "abovelock,swayosd"
      ];

      windowrule = [
        "float, class:(middleFloat)"
        "size 50% 50%, class:(middleFloat)"
        "float, initialClass:waypaper"
        "size 50% 50%, initialClass:waypaper"
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
        "float, initialTitle:Bluetooth Devices"
        "size 25% 50%, initialTitle:Bluetooth Devices"
      ];
      
      windowrulev2 = [
        "idleinhibit fullscreen, class:.*"
        "bordercolor rgba(7287fdff) rgba(7287fdaa), title:.*/home/deby.*"

        # fix for inconsistent color on chrome
        "bordercolor rgba(b0430cff) rgba(14161766), title:.* - Google Chrome"
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
        "sleep 3 && syncthing --no-browser" 
        "uwsm app -- clipse -listen" # Clipboard history
        "uwsm app -- dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "uwsm app -- systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "uwsm app -- nm-applet --indicator"
        "uwsm app -- ags"
        "uwsm app -- blueman-applet"
        "uwsm app -- pypr"
        "uwsm app -- vicinae server"
        "uwsm app -- swww-daemon"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "sleep 3 && systemctl --user restart clip-notify"
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
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; ${swayosd.output-volume}"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; ${swayosd.output-volume}"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; ${swayosd.output-volume}"
        "SHIFT, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle; ${swayosd.input-volume}"
        "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+; ${swayosd.input-volume}"
        "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-; ${swayosd.input-volume}"
        ",Caps_Lock,exec,${swayosd.caps-lock}"
      ];

      bind = [ 
        "CTRL ALT, N, exec, $terminal --class middleFloat -e hx"
        "$mod SHIFT, P, exec,  '${config.scriptsDir}/pass-wofi.sh'"
        "$mod SHIFT, W, exec, waypaper"
        "$mod,g,togglegroup"
        "$mod,i,pin"
        ", Print, exec, $hyprshot -z --clipboard-only -m region --freeze"
        "SHIFT, Print, exec, $hyprshot -z --clipboard-only -m window --freeze"
        "CTRL, Print, exec, $hyprshot -z --clipboard-only -m output --freeze"
        "$mod, L, exec, uwsm app -- hyprlock"
        # "$mod, D, exec, pkill wofi || uwsm app -- wofi --show drun -G --insensitive" #Main Menu
        "$mod, D, exec, uwsm app -- vicinae open" #Main Menu
        "$mod ALT, D, exec, pkill wofi || uwsm app -- wofi --show run -G --insensitive" #Main Menu
        "$mod, V, exec, pkill clipse & uwsm app -- $terminal --class middleFloat -e clipse"
        "CTRL ALT, N, exec, uwsm app -- $terminal --class middleFloat -e hx"
        "$mod, SPACE, togglefloating"
        "$mod, F, fullscreen, 1" # fake full screen 
        "$mod SHIFT, F, fullscreen"
        "$mod SHIFT, Q, killactive"
        "$mod, A, exec, pkill wofi || true && ags -t 'overview'"
        "$mod, Return, exec, uwsm app -- $terminal"  #terminal
        "$mod ALT, C, exec, pkill qalc & uwsm app -- $terminal --class middleFloat -e qalc" # calculator (qalculate)
        "$mod SHIFT, Return, exec, pypr toggle term" # Dropdown terminal
        "$mod, Z, exec, pypr zoom" # Toggle Desktop Zoom
        "$mod, E, exec, uwsm app -- $filesGUI"
        "$mod SHIFT, E, exec, uwsm app -- $terminal -e $files"

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
