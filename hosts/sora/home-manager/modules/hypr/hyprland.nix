{
  lib,
  pkgs,
  inputs,
  ...
}: let
  swayosd = {
    output-volume = "swayosd-client --output-volume +0";
    input-volume = "swayosd-client --input-volume +0";
    caps-lock = "sleep 0.2 && swayosd-client --caps-lock";
  };
  mod = "SUPER";
  terminal = "${lib.getExe pkgs.kitty}";
  files = "${lib.getExe pkgs.yazi}";
  filesGUI = "${lib.getExe pkgs.nemo-with-extensions}";
  qalc = "${lib.getExe pkgs.qalculate-gtk}";
  slurp = "${lib.getExe pkgs.slurp}";
  hyprshot = "${lib.getExe pkgs.hyprshot}";
  lock = "noctalia-shell ipc call lockScreen lock";
in {
  imports = [];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    # settings = {
    #   monitorv2 = [
    #     {
    #       output = "DP-1";
    #       mode = "1920x1080@239.76";
    #       position = "0x0";
    #       scale = 1;
    #       vrr = 0;
    #       # addreserved = "30,0,0,0";
    #     }
    #     {
    #       output = "HDMI-A-1";
    #       mode = "1920x1080@60";
    #       position = "1920x0";
    #       scale = 1;
    #       # addreserved = "30,0,0,0";
    #     }
    #   ];

    #   ecosystem.no_update_news = true;

    #   workspace = [
    #     "name:Browser,monitor:DP-1,persistent:true,default:true"
    #     "name:Social,monitor:HDMI-A-1,persistent:true,default:true"
    #     "name:Games,monitor:DP-1,persistent:true"
    #     "name:Extra,monitor:HDMI-A-1,persistent:true"
    #   ];

    #   master = {
    #     new_status = "slave";
    #     new_on_top = true;
    #     orientation = "right";
    #     mfact = 0.5;
    #   };

    #   general = {
    #     resize_on_border = true;
    #     allow_tearing = false;
    #     layout = "scrolling";
    #     border_size = 2;
    #     gaps_in = 6;
    #     gaps_out = 8;

    #     "col.active_border" = "rgba(BFA16Eff)";
    #     "col.inactive_border" = "rgba(BFA16E44)";
    #   };
    #   scrolling = {
    #     # Set to true so the 'camera' follows the window you focus
    #     follow_focus = true;

    #     # 0 = Center the window, 1 = Fit it to the nearest edge
    #     focus_fit_method = 1;
    #     fullscreen_on_one_column = true;

    #     # Default width of new windows (0.1 to 1.0)
    #     column_width = 0.5;
    #   };

    #   input = {
    #     kb_layout = "us,us";
    #     kb_variant = "alt-intl,";
    #     kb_model = "";
    #     kb_options = "grp:alt_space_toggle";
    #     kb_rules = "";
    #     repeat_rate = 50;
    #     repeat_delay = 300;

    #     sensitivity = -0.9;
    #     numlock_by_default = true;
    #     left_handed = false;
    #     follow_mouse = 2;
    #     mouse_refocus = false;
    #     float_switch_override_focus = true;
    #     tablet = {
    #       transform = 0;
    #       left_handed = 0;
    #     };
    #   };

    #   misc = {
    #     disable_hyprland_logo = true;
    #     disable_splash_rendering = true;
    #     vrr = 0;
    #     mouse_move_enables_dpms = true;
    #     enable_swallow = true;
    #     focus_on_activate = false;
    #     initial_workspace_tracking = 1;
    #     middle_click_paste = false;
    #   };

    #   binds = {
    #     workspace_back_and_forth = true;
    #     allow_workspace_cycles = true;
    #     pass_mouse_when_bound = true;
    #   };

    #   cursor = {
    #     no_hardware_cursors = true;
    #     enable_hyprcursor = true;
    #     warp_on_change_workspace = 1;
    #     no_warps = true;
    #   };

    #   decoration = {
    #     rounding = 0;
    #     rounding_power = 0;

    #     active_opacity = 1.0;
    #     inactive_opacity = 0.8;
    #     fullscreen_opacity = 1.0;

    #     dim_inactive = false;
    #     dim_strength = 0.1;
    #     dim_special = 0.8;

    #     shadow = {
    #       enabled = false;
    #       range = 1;
    #       render_power = 1;
    #       offset = "2.5 5";
    #       scale = 1;

    #       color = "rgba(00000044)";
    #       color_inactive = "rgba(00000022)";
    #     };

    #     blur = {
    #       enabled = true;
    #       size = 2;
    #       passes = 4;
    #       ignore_opacity = true;
    #       new_optimizations = true;
    #       special = true;
    #       popups = true;
    #     };
    #   };

    # animations = {
    #   enabled = "yes, please :)";

    #   bezier = [
    #     "easeout,0.5, 1, 0.9, 1"
    #     "easeoutback,0.34,1.22,0.65,1"
    #   ];

    #   animation = [
    #     "fadeIn,1,3,easeout"
    #     "fadeLayersIn,1,3,easeout"
    #     "fadeOut,1,3,easeout"
    #     "fadeLayersOut,1,3,easeout"
    #     "fadeSwitch,1,2,easeout"
    #     "fadeDim,1,3,easeout"
    #     "fadeShadow,1,2,easeout"
    #     "border,1,2,easeout"

    #     "layersIn,1,3,easeoutback,slide"
    #     "layersOut,1,3,easeoutback,slide"

    #     "windowsOut,1,3,easeout,slide"
    #     "windowsMove,1,3,easeoutback"
    #     "windowsIn,1,3,easeoutback,slide"

    #     "workspaces,1,2.5,easeoutback,slidefade"
    #   ];
    # };

    #   layerrule = [
    #     {
    #       name = "wofi";
    #       "match:namespace" = "wofi";
    #       blur = "on";
    #     }
    #     {
    #       name = "swayosd";
    #       "match:namespace" = "swayosd";
    #       above_lock = 2;
    #     }
    #     {
    #       name = "";
    #       "match:namespace" = "waybar";
    #       blur = "on";
    #       ignore_alpha = 1;
    #       # animation = "slide";
    #     }
    #     {
    #       name = "";
    #       "match:namespace" = "notifications";
    #       blur = "on";
    #       ignore_alpha = 1;
    #     }
    #     {
    #       name = "hyprpicker";
    #       "match:namespace" = "hyprpicker";
    #       animation = "fade";
    #     }
    #     {
    #       name = "selection";
    #       "match:namespace" = "selection";
    #       animation = "fade";
    #     }
    #     {
    #       name = "hyprpaper";
    #       "match:namespace" = "hyprpaper";
    #       animation = "fade";
    #     }
    #   ];

    #   windowrule = [
    #     {
    #       name = "firefoxBorderColorFix";
    #       "match:class" = "firefox";
    #       border_color = "rgba(5c4826ff) rgba(5c482644)";
    #     }
    #     {
    #       name = "middleFloatClass";
    #       "match:class" = "middleFloat";
    #       float = "on";
    #       size = "monitor_w/2 monitor_h/2";
    #     }
    #     {
    #       name = "waypaper";
    #       "match:initial_class" = "waypaper";
    #       float = "on";
    #       size = "monitor_w/2 monitor_h/2";
    #     }
    #     {
    #       name = "prismLauncher";
    #       "match:initial_class" = "org.prismlauncher.PrismLauncher";
    #       no_initial_focus = "on";
    #       workspace = "Extra";
    #       monitor = "DP-1";
    #     }
    #     {
    #       name = "steamClient";
    #       "match:initial_class" = "steam";
    #       no_initial_focus = "on";
    #       # tile = "on"; # Popus become glitchy with this on
    #       workspace = "Extra";
    #       monitor = "DP-1";
    #     }
    #     {
    #       name = "steamSettings";
    #       "match:initial_title" = "Steam Settings";
    #       float = "on";
    #       workspace = "Extra";
    #       monitor = "DP-1";
    #     }
    #     {
    #       name = "steamGames";
    #       "match:initial_class" = "steam_app.*";
    #       no_blur = "on";
    #       no_initial_focus = "on";
    #       # tile = "on";
    #       workspace = "Games";
    #       monitor = "DP-1";
    #     }
    #     {
    #       name = "minceraft";
    #       "match:initial_title" = "Minecraft.*";
    #       no_blur = "on";
    #       no_initial_focus = "on";
    #       tile = "on";
    #       workspace = "Games";
    #       monitor = "DP-1";
    #     }
    #     {
    #       name = "telegram";
    #       "match:initial_class" = "org.telegram.desktop";
    #       no_initial_focus = "on";
    #       workspace = "Social";
    #       monitor = "HDMI-A-1";
    #     }
    #     {
    #       name = "goofcord";
    #       "match:initial_class" = "goofcord";
    #       no_initial_focus = "on";
    #       workspace = "Social";
    #       monitor = "HDMI-A-1";
    #     }
    #     {
    #       name = "vesktop";
    #       "match:initial_class" = "vesktop";
    #       no_initial_focus = "on";
    #       workspace = "Social";
    #       monitor = "HDMI-A-1";
    #     }
    #     {
    #       name = "firefoxBrowser";
    #       "match:class" = "firefox";
    #       opacity = "2 2 2";
    #       workspace = "Browser";
    #       monitor = "DP-1";
    #     }
    #     # not working for some reason
    #     {
    #       name = "bitwardenBrowser";
    #       "match:class" = "firefox";
    #       "match:title" = "Extension: (Bitwarden Password Manager) - Bitwarden — Mozilla Firefox";
    #       float = "on";
    #       size = "window_w/2 window_h/2";
    #     }
    #     {
    #       name = "pwvucontrol";
    #       "match:initial_class" = "com.saivert.pwvucontrol";
    #       float = "on";
    #       size = "window_w/2 window_h/2";
    #     }
    #     {
    #       name = "folderSelector";
    #       "match:initial_title" = "Open Folder";
    #       float = "on";
    #       size = "window_w/4 window_h/2";
    #     }
    #     {
    #       name = "bluetooth";
    #       "match:initial_title" = "Bluetooth Devices";
    #       float = "on";
    #       size = "window_w/4 window_h/2";
    #     }
    #     {
    #       name = "sshColorTmpst";
    #       "match:title" = ".*tempest.*";
    #       border_size = 2;
    #       border_color = "rgba(7287fdff) rgba(7287fdaa)";
    #     }
    #   ];

    #   env = [
    #     "HYPRCURSOR_THEME,catppuccin-mocha-peach-cursors"
    #     "HYPRCURSOR_SIZE,24"
    #     "XDG_CURRENT_DESKTOP,Hyprland"
    #     "XDG_SESSION_DESKTOP,Hyprland"
    #   ];

    #   exec-once = [
    #     "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME"
    #     "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME"
    #     # "systemctl --user start hyprpolkitagent"
    #     "noctalia-shell -d"
    #     "clipse -listen" # Clipboard history
    #     "nm-applet --indicator"
    #     "sleep 5 && noctalia-shell ipc call lockScreen lock"
    #     "ags"
    #     "blueman-applet"
    #     "pypr"
    #     "vicinae server"
    #     "swww-daemon"
    #     "wl-paste --type text --watch cliphist store"
    #     "wl-paste --type image --watch cliphist store"
    #     "sleep 3 && systemctl --user restart clip-notify"
    #     "steam"
    #     "Telegram"
    #     "vesktop"
    #   ];

    #   binde = [
    #     "${mod} CTRL, left, resizeactive,-50 0"
    #     "${mod} CTRL, right, resizeactive,50 0"
    #     "${mod} CTRL, up, resizeactive,0 -50"
    #     "${mod} CTRL, down, resizeactive,0 50"
    #   ];

    #   bindr = [
    #   ];

    #   bindn = [
    #   ];

    #   bindm = [
    #     "${mod}, mouse:272, movewindow # NOTE: mouse:272 = left click"
    #     "${mod}, mouse:273, resizewindow # NOTE: mouse:272 = right click"
    #   ];

    #   bindl = [
    #     ", XF86AudioPlay, exec, playerctl play-pause"
    #     ", XF86AudioNext, exec, playerctl next"
    #     ", XF86AudioPrev, exec, playerctl previous"
    #     ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # ; ${swayosd.output-volume}"
    #     ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" # ; ${swayosd.output-volume}"
    #     ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" # ; ${swayosd.output-volume}"
    #     "SHIFT, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" # ; ${swayosd.input-volume}"
    #     "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+" #; ${swayosd.input-volume}"
    #     "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-" #; ${swayosd.input-volume}"
    #     # ",Caps_Lock,exec,${swayosd.caps-lock}"
    #   ];

    #   bind = [
    #     # pypr
    #     "${mod} SHIFT, Return, exec, pypr toggle term" # Dropdown terminal
    #     "${mod} SHIFT, V, exec, pypr toggle volume" # Pavucontrol

    #     "${mod}, M, exec, noctalia-shell ipc call sessionMenu toggle"
    #     "${mod} SHIFT, W, exec, noctalia-shell ipc call wallpaper toggle"

    #     "CTRL ALT, N, exec, ${terminal} --class middleFloat -e hx"
    #     "${mod} SHIFT, P, exec,  '${../../../../../scripts/pass-wofi.sh}'"
    #     "${mod},g,togglegroup"
    #     "${mod},i,pin"
    #     ", Print, exec, ${hyprshot} -z --clipboard-only -m region --freeze"
    #     "CTRL, Print, exec, ${hyprshot} -z --clipboard-only -m output --freeze"
    #     "${mod}, L, exec, ${lock}"
    #     # "${mod} SHIFT, D, exec, pkill wofi || wofi --show drun -G --insensitive" # Main Menu
    #     # "${mod} SHIFT, D, exec, vicinae open"
    #     "${mod} SHIFT, D, exec, walker"
    #     "${mod}, D, exec, fuzzel"
    #     "${mod} ALT, D, exec, pkill wofi || wofi --show run -G --insensitive" # Main Menu
    #     "${mod}, V, exec, pkill clipse & ${terminal} --class middleFloat -e clipse"
    #     "${mod}, SPACE, togglefloating"
    #     # "${mod}, F, layoutmsg, togglefit || " # niri like fullscreen
    #     # "${mod}, F, fullscreen, 1" # fake fullscreen
    #     "${mod}, F, layoutmsg , fit active"
    #     "${mod} CTRL, F, layoutmsg , colresize 0.5"
    #     "${mod} SHIFT, F, fullscreen"
    #     "${mod} SHIFT, Q, killactive"
    #     "${mod}, A, exec, pkill wofi || true && ags -t 'overview'"
    #     "${mod}, Return, exec, ${terminal}" # terminal
    #     "${mod} ALT, C, exec, pkill qalc & ${terminal} --class middleFloat -e qalc" # calculator (qalculate)
    #     "${mod}, Z, exec, pypr zoom" # Toggle Desktop Zoom
    #     "${mod}, E, exec, ${filesGUI}"
    #     "${mod} SHIFT, E, exec, ${terminal} -e ${files}"

    #     # Switch workspaces with {mod} + [0-9]
    #     "${mod}, 1, workspace, Browser"
    #     "${mod}, 2, workspace, Social"
    #     "${mod}, 3, workspace, Games"
    #     "${mod}, 4, workspace, Extra"
    #     "${mod}, 5, workspace, 5"
    #     "${mod}, 6, workspace, 6"
    #     "${mod}, 7, workspace, 7"
    #     "${mod}, 8, workspace, 8"
    #     "${mod}, 9, workspace, 9"
    #     "${mod}, 0, workspace, 10"

    #     # Move active window and follow to workspace {mod} + SHIFT [0-9]
    #     "${mod} SHIFT, 1, movetoworkspace, Browser"
    #     "${mod} SHIFT, 2, movetoworkspace, Social"
    #     "${mod} SHIFT, 3, movetoworkspace, Games"
    #     "${mod} SHIFT, 4, movetoworkspace, Extra"
    #     "${mod} SHIFT, 5, movetoworkspace, 5"
    #     "${mod} SHIFT, 6, movetoworkspace, 6"
    #     "${mod} SHIFT, 7, movetoworkspace, 7"
    #     "${mod} SHIFT, 8, movetoworkspace, 8"
    #     "${mod} SHIFT, 9, movetoworkspace, 9"
    #     "${mod} SHIFT, 0, movetoworkspace, 10"
    #     "${mod} SHIFT, bracketleft, movetoworkspace, -1 # brackets ["
    #     "${mod} SHIFT, bracketright, movetoworkspace, +1 # brackets ]"

    #     # Move active window and do not follow to workspace {mod} + CTRL [0-9]
    #     "${mod} CTRL, 1, movetoworkspacesilent, Browser"
    #     "${mod} CTRL, 2, movetoworkspacesilent, Social"
    #     "${mod} CTRL, 3, movetoworkspacesilent, Games"
    #     "${mod} CTRL, 4, movetoworkspacesilent, extra"
    #     "${mod} CTRL, 5, movetoworkspacesilent, 5"
    #     "${mod} CTRL, 6, movetoworkspacesilent, 6"
    #     "${mod} CTRL, 7, movetoworkspacesilent, 7"
    #     "${mod} CTRL, 8, movetoworkspacesilent, 8"
    #     "${mod} CTRL, 9, movetoworkspacesilent, 9"
    #     "${mod} CTRL, 0, movetoworkspacesilent, 10"

    #     # Move focus with {mod} + arrow keys
    #     "${mod}, left, layoutmsg, focus l"
    #     "${mod}, right, layoutmsg, focus r"
    #     "${mod}, up, layoutmsg, focus u"
    #     "${mod}, down, layoutmsg, focus d"

    #     # Move windows
    #     "${mod} SHIFT, left, movewindow, l"
    #     "${mod} SHIFT, right, movewindow, r"
    #     "${mod} SHIFT, up, movewindow, u"
    #     "${mod} SHIFT, down, movewindow, d"

    #     # Dwindle Layout
    #     # "${mod} SHIFT, I, togglesplit # only works on dwindle layout"
    #     "${mod}, P, pseudo, # dwindle"
    #   ];

    #   # For passthrough keyboard into a VM
    #   # bind = ${mod}ALT, P, submap, passthru
    #   #submap = passthru
    #   # to unbind
    #   #bind = ${mod}ALT, P, submap, reset
    #   #submap = reset
    # };

    # builtins.readFile ./hyprConfig.lua;
    extraConfig =
      #language=lua
      ''
        ------------------------------- GENERAL -------------------------------
        hl.config({
          ecosystem = {
            no_update_news = true,
            no_donation_nag = true,
          },

          general = {
            resize_on_border = true,
            allow_tearing = false,
            layout = "scrolling",
            border_size = 2,
            gaps_in = 6, gaps_out = 8,
            col = { active_border = "rgba(BFA16Eff)", inactive_border = "rgba(BFA16E44)" },
          },

          input = {
            kb_layout = "us,us",
            kb_variant = "alt-intl,",
            kb_model = "",
            kb_options = "grp:alt_space_toggle",
            kb_rules = "",
            repeat_rate = 50,
            repeat_delay = 300,
            sensitivity = -0.9,
            numlock_by_default = true,
            left_handed = false,
            follow_mouse = 2,
            mouse_refocus = false,
            float_switch_override_focus = true,
            tablet = {
              transform = 0,
              left_handed = 0,
            },
          },

          misc = {
            disable_hyprland_logo = true,
            disable_splash_rendering = true,
            vrr = 0,
            mouse_move_enables_dpms = true,
            enable_swallow = true,
            focus_on_activate = false,
            initial_workspace_tracking = 1,
            middle_click_paste = false,
          },

          binds = {
            workspace_back_and_forth = true,
            allow_workspace_cycles = true,
            pass_mouse_when_bound = true
          },

          cursor = {
            no_hardware_cursors = true,
            enable_hyprcursor = true,
            warp_on_change_workspace = 1,
            no_warps = true,
          },

          decoration = {
            rounding = 0,
            rounding_power = 0,
            active_opacity = 1.0,
            inactive_opacity = 0.8,
            fullscreen_opacity = 1.0,
            dim_inactive = false,
            dim_strength = 0.1,
            dim_special = 0.8,

            shadow = {
              enabled = false,
              range = 1,
              render_power = 1,
              offset = "2.5 5",
              scale = 1,
              color = "rgba(00000044)",
              color_inactive = "rgba(00000022)",
            },
            blur = {
              enabled = true,
              size = 2,
              passes = 4,
              ignore_opacity = true,
              new_optimizations = true,
              special = true,
              popups = true,
            },
          },
        })
        -----------------------------------------------------------------------

        ------------------------------- ANIMATIONS ----------------------------
        hl.config({ animations = { enabled = true } })

        hl.curve("easeout", { type = "bezier", points = { {0.5, 1}, {0.9, 1} } })
        hl.curve("easeoutback", { type = "bezier", points = { {0.34, 1.22}, {0.65, 1} } })

        local elements = {
          {"fadeIn", 3, "easeout"},
          {"fadeLayersIn", 3, "easeout"},
          {"fadeOut", 3, "easeout"},
          {"fadeLayersOut", 3, "easeout"},
          {"fadeSwitch", 2, "easeout"},
          {"fadeDim", 3, "easeout"},
          {"fadeShadow", 2, "easeout"},
          {"border", 2, "easeout"},
          {"layersIn", 3, "easeoutback", "slide"},
          {"layersOut", 3, "easeoutback", "slide"},
          {"windowsOut", 3, "easeout", "slide"},
          {"windowsMove", 3, "easeoutback"},
          {"windowsIn", 3, "easeoutback", "slide"},
          {"workspaces", 2.5, "easeoutback", "slidefade"},
        }

        for _, v in ipairs(elements) do
          hl.animation({ leaf = v[1], enabled = true, speed = v[2], bezier = v[3], style = v[4] })
        end
        -----------------------------------------------------------------------

        ------------------------------- MONITORS -------------------------------
        hl.monitor({ output = "DP-1", mode = "highrr", position = "0x0", scale= 1 })
        hl.monitor({ output = "HDMI-A-1", mode = "highres", position = "1920x0", scale= 1 })
        ------------------------------------------------------------------------

        ------------------------------- WORKSPACE RULES -------------------------------
        hl.workspace_rule({ workspace = "name:Browser", monitor = "DP-1", persistent = true, default = true })
        hl.workspace_rule({ workspace = "name:Social", monitor = "HDMI-A-1", persistent = true, default = true })
        hl.workspace_rule({ workspace = "name:Games", monitor = "DP-1", persistent = true, default = true })
        hl.workspace_rule({ workspace = "name:Extra", monitor = "DP-1", persistent = true, default = true })
        -------------------------------------------------------------------------------

        ------------------------------- WINDOW/LAYER RULES -------------------------------
        hl.layer_rule({ match = {namespace = "wofi"}, blur = true })
        hl.layer_rule({ match = {namespace = "swayosd"}, above_lock = 2 })
        hl.layer_rule({ match = {namespace = "waybar"}, blur = true, ignore_alpha = 1 })
        hl.layer_rule({ match = {namespace = "notifications"}, blur = true, ignore_alpha = 1 })
        hl.layer_rule({ match = {namespace = "hyprpicker"}, animation = "fade" })
        hl.layer_rule({ match = {namespace = "selection"}, animation = "fade" })
        hl.layer_rule({ match = {namespace = "hyprpaper"}, animation = "fade" })

        hl.window_rule({
          name = "firefoxBorderColorFix",
          match = {class = "firefox"},
          border_color = "rgba(5c4826ff) rgba(5c482644)",
        })

        hl.window_rule({
          name = "middleFloatClass",
          match = { class = "middleFloat" },
          float = true,
          size = "monitor_w/2 monitor_h/2",
        })

        hl.window_rule({
          name = "waypaper",
          match = { initial_class = "waypaper" },
          float = true,
          size = "monitor_w/2 monitor_h/2",
        })

        hl.window_rule({
          name = "prismLauncher",
          match = { initial_class = "org.prismlauncher.PrismLauncher" },
          no_initial_focus = true,
          workspace = "Extra",
          monitor = "DP-1",
        })

        hl.window_rule({
          name = "steamClient",
          match = { initial_class = "steam" },
          no_initial_focus = true,
          -- tile = true, -- Popups become glitchy with this on
          workspace = "Extra",
          monitor = "DP-1",
        })

        hl.window_rule({
          name = "steamSettings",
          match = { initial_title = "Steam Settings" },
          float = true,
          workspace = "Extra",
          monitor = "DP-1",
        })

        hl.window_rule({
          name = "steamGames",
          match = { initial_class = "steam_app.*" },
          no_blur = true,
          no_initial_focus = true,
          -- tile = true,
          workspace = "Games",
          monitor = "DP-1",
        })

        hl.window_rule({
          name = "minceraft",
          match = { initial_title = "Minecraft.*" },
          no_blur = true,
          no_initial_focus = true,
          tile = true,
          workspace = "Games",
          monitor = "DP-1",
        })

        hl.window_rule({
          name = "telegram",
          match = { initial_class = "org.telegram.desktop" },
          no_initial_focus = true,
          workspace = "Social",
          monitor = "HDMI-A-1",
        })

        hl.window_rule({
          name = "goofcord",
          match = { initial_class = "goofcord" },
          no_initial_focus = true,
          workspace = "Social",
          monitor = "HDMI-A-1",
        })

        hl.window_rule({
          name = "vesktop",
          match = { initial_class = "vesktop" },
          no_initial_focus = true,
          workspace = "Social",
          monitor = "HDMI-A-1",
        })

        hl.window_rule({
          name = "firefoxBrowser",
          match = { class = "firefox" },
          opacity = "2 2 2",
          workspace = "Browser",
          monitor = "DP-1",
        })

        -- not working for some reason
        hl.window_rule({
          name = "bitwardenBrowser",
          match = { class = "firefox" },
          match = { title = "Extension: (Bitwarden Password Manager) - Bitwarden.*" },
          float = true,
          size = "window_w/2 window_h/2",
        })

        hl.window_rule({
          name = "pwvucontrol",
          match = { initial_class = "com.saivert.pwvucontrol" },
          float = true,
          size = "window_w/2 window_h/2",
        })

        hl.window_rule({
          name = "folderSelector",
          match = { initial_title = "Open Folder" },
          float = true,
          size = "window_w/4 window_h/2",
        })

        hl.window_rule({
          name = "bluetooth",
          match = { initial_title = "Bluetooth Devices" },
          float = true,
          size = "window_w/4 window_h/2",
        })

        hl.window_rule({
          name = "sshColorTmpst",
          match = { title = ".*tempest.*" },
          border_size = 2,
          border_color = "rgba(7287fdff) rgba(7287fdaa)",
        })
        -----------------------------------------------------------------------

        ------------------------------- ENV VARS -------------------------------
        hl.env( "HYPRCURSOR_THEME", "catppuccin-mocha-peach-cursors" )
        hl.env( "HYPRCURSOR_SIZE", "24" )
        hl.env( "XDG_CURRENT_DESKTOP", "Hyprland" )
        hl.env( "XDG_SESSION_DESKTOP", "Hyprland" )
        ----------------------------------------------------------------

        ------------------------------- LAYOUTS -------------------------------
        hl.config({ master = { new_status = "slave", new_on_top = true, orientation = "right", mfact = 0.5 } })
        hl.config({ scrolling = {follow_focus = true, focus_fit_method = 1, fullscreen_on_one_column = true, column_width = 0.5 } })
        -----------------------------------------------------------------------

        ------------------------------- EXEC ON START -------------------------------
        hl.on("hyprland.start", function ()
          hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME")
          hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORM QT_QPA_PLATFORMTHEME")
          -- hl.exec_cmd("systemctl --user start hyprpolkitagent")
          hl.exec_cmd("noctalia-shell -d")
          hl.exec_cmd("clipse -listen")
          hl.exec_cmd("nm-applet --indicator")
          hl.exec_cmd("sleep 5 && noctalia-shell ipc call lockScreen lock")
          hl.exec_cmd("ags")
          hl.exec_cmd("blueman-applet")
          hl.exec_cmd("pypr")
          hl.exec_cmd("vicinae server")
          hl.exec_cmd("swww-daemon")
          hl.exec_cmd("wl-paste --type text --watch cliphist store")
          hl.exec_cmd("wl-paste --type image --watch cliphist store")
          hl.exec_cmd("sleep 3 && systemctl --user restart clip-notify")
          hl.exec_cmd("steam")
          hl.exec_cmd("Telegram")
          hl.exec_cmd("vesktop")
        end)
        ----------------------------------------------------------------

        ------------------------------- BINDS -------------------------------
        hl.bind("${mod} + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- mouse:272 = left click
        hl.bind("${mod} + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- mouse:273 = right click

        hl.bind("${mod} + SHIFT + Q", hl.dsp.window.kill())
        hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
        hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
        hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
        hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true }) -- ; ${swayosd.output-volume}
        hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true }) -- ; ${swayosd.output-volume}
        hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true }) -- ; ${swayosd.output-volume}
        hl.bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true }) -- ; ${swayosd.input-volume}
        hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"), { locked = true, repeating = true }) -- ; ${swayosd.input-volume}"
        hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"), { locked = true, repeating = true }) -- ; ${swayosd.input-volume}"
        -- ",Caps_Lock,exec,${swayosd.caps-lock}"
        hl.bind("${mod} + SHIFT + Return", hl.dsp.exec_cmd("pypr toggle term")) -- Dropdown terminal
        hl.bind("${mod} + SHIFT + V", hl.dsp.exec_cmd("pypr toggle volume")) -- Pavucontrol
        hl.bind("${mod} + M", hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu toggle"))
        hl.bind("${mod} + SHIFT + W", hl.dsp.exec_cmd("noctalia-shell ipc call wallpaper toggle"))
        hl.bind("CTRL + ALT + N", hl.dsp.exec_cmd("${terminal} --class middleFloat -e hx"))
        hl.bind("${mod} + SHIFT + P", hl.dsp.exec_cmd("'${../../../../../scripts/pass-wofi.sh}'"))
        hl.bind("${mod} + I", hl.dsp.window.pin({ action = "toggle" }))
        hl.bind("Print", hl.dsp.exec_cmd("${hyprshot} -z --clipboard-only -m region --freeze"))
        hl.bind("CTRL + Print", hl.dsp.exec_cmd("${hyprshot} -z --clipboard-only -m output --freeze"))
        hl.bind("${mod} + L", hl.dsp.exec_cmd("${lock}"))
        -- "${mod} + SHIFT + D", hl.dsp.exec_cmd("pkill wofi || wofi --show drun -G --insensitive" -- Main Menu
        -- "${mod} + SHIFT + D", hl.dsp.exec_cmd("vicinae open"
        hl.bind("${mod} + D", hl.dsp.exec_cmd("fuzzel"))
        hl.bind("${mod} + ALT + D", hl.dsp.exec_cmd("pkill wofi || wofi --show run -G --insensitive")) -- Main Menu
        hl.bind("${mod} + V", hl.dsp.exec_cmd("pkill clipse & ${terminal} --class middleFloat -e clipse"))
        hl.bind("${mod} + SPACE", hl.dsp.window.float({ action = "toggle" }))
        -- hl.bind("${mod} + F", hl.dsp.layout("togglefit || ")) -- niri like fullscreen, does not work yet tho
        -- hl.bind("${mod} + F", hl.dsp.window.fullscreen({ mode = "maximized"})) -- fake fullscreen
        hl.bind("${mod} + SHIFT + Q", hl.dsp.window.kill)
        hl.bind("${mod} + A", hl.dsp.exec_cmd("pkill wofi || true && ags -t 'overview'"))
        hl.bind("${mod} + RETURN", hl.dsp.exec_cmd("${terminal}")) -- terminal
        hl.bind("${mod} + ALT + C", hl.dsp.exec_cmd("pkill qalc & ${terminal} --class middleFloat -e qalc")) -- calculator (qalculate)
        hl.bind("${mod} + Z", hl.dsp.exec_cmd("pypr zoom")) -- Toggle Desktop Zoom
        hl.bind("${mod} + E", hl.dsp.exec_cmd("${filesGUI}"))
        hl.bind("${mod} + SHIFT + E", hl.dsp.exec_cmd("${terminal} -e ${files}"))
        hl.bind("${mod} + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

        -- Dynamic maximized toggle
        local is_maximized = false
        hl.bind("${mod} + F", function()
          if is_maximized then
            hl.dispatch(hl.dsp.layout("colresize 0.5")) -- Returns column to 0.5
            is_maximized = false
          else
            hl.dispatch(hl.dsp.layout("fit active")) -- Maximizes active column
            is_maximized = true
          end
        end)
        -- TODO: Remove if function above works
        -- hl.bind("${mod} + F", hl.dsp.layout("fit active"))
        -- hl.bind("${mod} + CTRL + F", hl.dsp.layout("colresize 0.5"))
        -----------------------------------------------------------------------

        ------------------------------- Workspace/Window keys -------------------------------
        -- Map keys 1 through 9, and 0 (for workspace 10)
        for i = 5, 10 do
          local key = i % 10  -- Maps index 10 to key "0"

          -- Focus workspace
          hl.bind("${mod} +" .. key, hl.dsp.focus({ workspace = i }))

          -- Move active window to workspace and follow
          hl.bind("${mod} + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))

          -- Move active window to workspace and DON'T follow
          hl.bind("${mod} + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
        end
        -- Switch workspaces [1-4]
        hl.bind("${mod} + 1", hl.dsp.focus({ workspace = "Browser"}))
        hl.bind("${mod} + 2", hl.dsp.focus({ workspace = "Social"}))
        hl.bind("${mod} + 3", hl.dsp.focus({ workspace = "Games"}))
        hl.bind("${mod} + 4", hl.dsp.focus({ workspace = "Extra"}))
        -- Move active window to workspace and follow [1-4]
        hl.bind("${mod} + SHIFT + 1", hl.dsp.window.move({ workspace = "Browser", follow = true }))
        hl.bind("${mod} + SHIFT + 2", hl.dsp.window.move({ workspace = "Social", follow = true }))
        hl.bind("${mod} + SHIFT + 3", hl.dsp.window.move({ workspace = "Games", follow = true }))
        hl.bind("${mod} + SHIFT + 4", hl.dsp.window.move({ workspace = "Extra", follow = true }))
        -- Move active to workspace window and DON'T follow [1-4]
        hl.bind("${mod} + CTRL + 1", hl.dsp.window.move({ workspace = "Browser", follow = false }))
        hl.bind("${mod} + CTRL + 2", hl.dsp.window.move({ workspace = "Social", follow = false }))
        hl.bind("${mod} + CTRL + 3", hl.dsp.window.move({ workspace = "Games", follow = false }))
        hl.bind("${mod} + CTRL + 4", hl.dsp.window.move({ workspace = "Extra", follow = false }))
        -- Move focus with arrow keys
        hl.bind("${mod} + left",  hl.dsp.layout("focus l"))
        hl.bind("${mod} + right", hl.dsp.layout("focus r"))
        hl.bind("${mod} + up",    hl.dsp.layout("focus u"))
        hl.bind("${mod} + down",  hl.dsp.layout("focus d"))
        -- Move windows with arrow keys
        hl.bind("${mod} + SHIFT + left",  hl.dsp.window.move({ direction = "l"}))
        hl.bind("${mod} + SHIFT + right", hl.dsp.window.move({ direction = "r"}))
        hl.bind("${mod} + SHIFT + up",    hl.dsp.window.move({ direction = "u"}))
        hl.bind("${mod} + SHIFT + down",  hl.dsp.window.move({ direction = "d"}))
        -----------------------------------------------------------------------
      '';
  };
}
