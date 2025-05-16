{ inputs, lib, config, pkgs, ... }: {

	wayland.windowManager.hyprland = lib.mkForce {
		enable = true;
		xwayland.enable = true;
		plugins = [];
		systemd = {
			enable = true;
			variables = ["--all"];
		};
		settings = {

			"$mainMod"    = "SUPER";
			"$terminal"   = "${pkgs.kitty}/bin/kitty";
			"$files"      = "${pkgs.kitty}/bin/kitty -e ${pkgs.ranger}/bin/ranger";
			"$qalc" 			= "${pkgs.qalculate-gtk}/bin/qalculate-gtk";
			"$slurp" 			= "${pkgs.slurp}/bin/slurp";
			"$hyprshot"   = "${pkgs.hyprshot}/bin/hyprshot";

			monitor = [ 
				"DP-3,1920x1080@239.76,0x0,1"
				"HDMI-A-1,1920x1080@60,1920x-250,1"
#"HDMI-A-1,disable"
			];

			workspace = [
				"1, monitor:DP-3, persistent:true"
				"2, monitor:HDMI-A-1, persistent:true"
			];

			dwindle = {	
				pseudotile = "yes";
				preserve_split = "yes";
				special_scale_factor = 0.8;
			};

			master = {
				new_status = "master";	
				new_on_top = 1;
				mfact = 0.5;
			};

			general = {
				resize_on_border = true;
				allow_tearing = true;
				layout = "dwindle";
				border_size = 2;
				gaps_in = 8;
				gaps_out = 8;

				"col.active_border" = "rgba(fab38788) rgba(f38ba888) 45deg";
				"col.inactive_border" = "rgb(dd7878)";
			};

			input = {
				kb_layout = "us";
				kb_variant = ""; 
				kb_model = "";
				kb_options = "";
				kb_rules = "";
				repeat_rate = 50;
				repeat_delay = 300;

				sensitivity = -0.7;
				numlock_by_default = true;
				left_handed = false;
				follow_mouse = true;
				float_switch_override_focus = false;
				tablet = {
					transform = 0;
					left_handed = 0;
				};
			};

			misc = {
				disable_hyprland_logo = true;
				disable_splash_rendering = true;
				vfr = true;
				vrr = 2;
				mouse_move_enables_dpms = true;
				enable_swallow = true;
				focus_on_activate = false;
				initial_workspace_tracking = 0;
				middle_click_paste = false;
			};

			binds = {
				workspace_back_and_forth = false;
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
				rounding = 6;

				active_opacity = 2.0;
				inactive_opacity = 0.8;
				fullscreen_opacity = 1.0;

				dim_inactive = true;
				dim_strength = 0.1;
				dim_special = 0.8;

				shadow = {
					enabled = true;
					range = 3;
					render_power = 1;

#"color" = "$color12";
#"color_inactive" = "$color10";
				};

				blur = {
					enabled = true;
					size = 4;
					passes = 2;
					ignore_opacity = true;
					new_optimizations = true;
					special = true;
					popups = true;
				};
			};

			group = {
#"col.border_active" = "$color15";

				groupbar = {
#"col.active" = "$color0";
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
					"windowsIn, 1, 5, slow, popin"
					"windowsOut, 1, 5, winOut, popin"
					"windowsMove, 1, 5, wind, slide"
					"border, 1, 2, linear"
					"borderangle, 1, 180, linear, loop" #used by rainbow borders and rotating colors
					"fade, 1, 5, overshot"
					"workspaces, 1, 5, wind"
					"windows, 1, 5, bounce, popin"
				];
			};

			layerrule = ["blur, wofi"];
			
			windowrule = [
				"noblur, tag:games*"
				"opacity 2 2 2, class:google-chrome"
				"float, initialClass:chrome-nngceckbapebfimnlniiiahkandclblb-Default"
				"size 25% 50%, initialClass:chrome-nngceckbapebfimnlniiiahkandclblb-Default"
				"float, initialClass:org.pulseaudio.pavucontrol"
				"size 50% 50%, initialClass:org.pulseaudio.pavucontrol"
			];

			env = [ 
				"NIXOS_OZONE_WL,1"
				"EDITOR,neovim #default editor"
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
			];

			exec-once = [ 
        "pkill waybar || waybar"
				"swww-daemon --format xrgb"
				#"$SwwwRandom $wallDIR # random wallpaper switcher every 30 minutes "
				"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
				"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
				#"$scriptsDir/Polkit.sh"
				"nm-applet --indicator &"
				"swaync &"
				"ags &"
				"blueman-applet & "
				"rog-control-center &"
				"wl-paste --type text --watch cliphist store "
				"wl-paste --type image --watch cliphist store"
#"$UserScripts/RainbowBorders.sh &"
				"hypridle &"
				"pypr &"
				"swww-daemon --format xrgb && swww img ./../../../hosts/rakki/wallpapers/agbg.jpg  # persistent wallpaper"
#"$scriptsDir/Polkit-NixOS.sh"
				"sleep 5 && hyprlock"
			];

			binde = [
				"$mainMod CTRL, left, resizeactive,-50 0"
				"$mainMod CTRL, right, resizeactive,50 0"
				"$mainMod CTRL, up, resizeactive,0 -50"
				"$mainMod CTRL, down, resizeactive,0 50"
			];

			bindr = [ 
			];

			bindn = [ 
			];

			bindm = [
				"$mainMod, mouse:272, movewindow # NOTE: mouse:272 = left click"
				"$mainMod, mouse:273, resizewindow # NOTE: mouse:272 = right click"
			];

			bindl = [
				", Print, exec, $hyprshot -z --clipboard-only -m region"
				#	"bindl = , xf86AudioPlayPause, exec, $scriptsDir/MediaCtrl.sh --pause"
				#	"bindl = , xf86AudioPause, exec, $scriptsDir/MediaCtrl.sh --pause"
				#	"bindl = , xf86AudioPlay, exec, $scriptsDir/MediaCtrl.sh --pause"
				#	"bindl = , xf86AudioNext, exec, $scriptsDir/MediaCtrl.sh --nxt "
				#	"bindl = , xf86AudioPrev, exec, $scriptsDir/MediaCtrl.sh --prv"
				#	"bindl = , xf86audiostop, exec, $scriptsDir/MediaCtrl.sh --stop"
			];

			bind = [ 
				"$mainMod, M, exec, hyprctl dispatch exit"
				"$mainMod, L, exec, hyprlock"
				"$mainMod, D, exec, pkill wofi || wofi --show drun -G --insensitive" #Main Menu
				"$mainMod ALT, D, exec, pkill wofi || wofi --show run -G --insensitive" #Main Menu
				"$mainMod, V, exec, cliphist list | wofi --show dmenu -G | wl-copy"
				"$mainMod, SPACE, togglefloating"
				"$mainMod SHIFT, F, fullscreen, 1 # fake full screen"
				"$mainMod, F, fullscreen"
				"$mainMod SHIFT, Q, killactive"
				"$mainMod, A, exec, pkill rofi || true && ags -t 'overview'"
				"$mainMod, Return, exec, $terminal"  #terminal
				"$mainMod, T, exec, $files" #file manager
				"$mainMod ALT, C, exec, [size 50% 50%;float] $terminal -e qalc" # calculator (qalculate)
				"$mainMod SHIFT, Return, exec, pypr toggle term" # Dropdown terminal
				"$mainMod, Z, exec, pypr zoom # Toggle Desktop Zoom"

				# Switch workspaces with mainMod + [0-9] 
				"$mainMod, code:10, workspace, 1 # NOTE: code:10 = key 1"
				"$mainMod, code:11, workspace, 2 # NOTE: code:11 = key 2"
				"$mainMod, code:12, workspace, 3 # NOTE: code:12 = key 3"
				"$mainMod, code:13, workspace, 4 # NOTE: code:13 = key 4"
				"$mainMod, code:14, workspace, 5 # NOTE: code:14 = key 5"
				"$mainMod, code:15, workspace, 6 # NOTE: code:15 = key 6"
				"$mainMod, code:16, workspace, 7 # NOTE: code:16 = key 7"
				"$mainMod, code:17, workspace, 8 # NOTE: code:17 = key 8"
				"$mainMod, code:18, workspace, 9 # NOTE: code:18 = key 9"
				"$mainMod, code:19, workspace, 10 # NOTE: code:19 = key 0"

				# Move active window and follow to workspace mainMod + SHIFT [0-9]
				"$mainMod SHIFT, code:10, movetoworkspace, 1 # NOTE: code:10 = key 1"
				"$mainMod SHIFT, code:11, movetoworkspace, 2 # NOTE: code:11 = key 2"
				"$mainMod SHIFT, code:12, movetoworkspace, 3 # NOTE: code:12 = key 3"
				"$mainMod SHIFT, code:13, movetoworkspace, 4 # NOTE: code:13 = key 4"
				"$mainMod SHIFT, code:14, movetoworkspace, 5 # NOTE: code:14 = key 5"
				"$mainMod SHIFT, code:15, movetoworkspace, 6 # NOTE: code:15 = key 6"
				"$mainMod SHIFT, code:16, movetoworkspace, 7 # NOTE: code:16 = key 7"
				"$mainMod SHIFT, code:17, movetoworkspace, 8 # NOTE: code:17 = key 8"
				"$mainMod SHIFT, code:18, movetoworkspace, 9 # NOTE: code:18 = key 9"
				"$mainMod SHIFT, code:19, movetoworkspace, 10 # NOTE: code:19 = key 0"
				"$mainMod SHIFT, bracketleft, movetoworkspace, -1 # brackets ["
				"$mainMod SHIFT, bracketright, movetoworkspace, +1 # brackets ]"


				# Move active window and do not follow to workspace mainMod + CTRL [0-9]
				"$mainMod CTRL, code:10, movetoworkspacesilent, 1 # NOTE: code:10 = key 1"
				"$mainMod CTRL, code:11, movetoworkspacesilent, 2 # NOTE: code:11 = key 2"
				"$mainMod CTRL, code:12, movetoworkspacesilent, 3 # NOTE: code:12 = key 3"
				"$mainMod CTRL, code:13, movetoworkspacesilent, 4 # NOTE: code:13 = key 4"
				"$mainMod CTRL, code:14, movetoworkspacesilent, 5 # NOTE: code:14 = key 5"
				"$mainMod CTRL, code:15, movetoworkspacesilent, 6 # NOTE: code:15 = key 6"
				"$mainMod CTRL, code:16, movetoworkspacesilent, 7 # NOTE: code:16 = key 7"
				"$mainMod CTRL, code:17, movetoworkspacesilent, 8 # NOTE: code:17 = key 8"
				"$mainMod CTRL, code:18, movetoworkspacesilent, 9 # NOTE: code:18 = key 9"
				"$mainMod CTRL, code:19, movetoworkspacesilent, 10 # NOTE: code:19 = key 0"

				# Move focus with mainMod + arrow keys
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"

				# Move windows
				"$mainMod SHIFT, left, movewindow, l"
				"$mainMod SHIFT, right, movewindow, r"
				"$mainMod SHIFT, up, movewindow, u"
				"$mainMod SHIFT, down, movewindow, d"

				# Dwindle Layout
				"$mainMod SHIFT, I, togglesplit # only works on dwindle layout"
				"$mainMod, P, pseudo, # dwindle"
			];

			# For passthrough keyboard into a VM
			# bind = $mainModALT, P, submap, passthru
			#submap = passthru
			# to unbind
			#bind = $mainModALT, P, submap, reset
			#submap = reset
		};
	};
																		}
