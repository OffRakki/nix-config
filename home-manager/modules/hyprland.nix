{ inputs, lib, config, pkgs, ... }: {

	wayland.windowManager.hyprland = {
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
			"$qalc" = "${pkgs.qalculate-gtk}/bin/qalculate-gtk";

			monitor = [ 
				"DP-3,1920x1080@239.76,0x0,1"
				"HDMI-A-1,highres,1920x-250,1"
#"HDMI-A-1,disable"
			];

			workspace = [
				"1, monitor:DP-3"
				"2, monitor:HDMI-A-1"
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
				gaps_in = 4;
				gaps_out = 6;

				"col.active_border" = "rgba(fe640baa) rgba(df8e1daa) 45deg";
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
				workspace_back_and_forth = true;
				allow_workspace_cycles = true;
				pass_mouse_when_bound = false;
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
				inactive_opacity = 0.9;
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
					size = 6;
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

			windowrule = [
				"noblur, tag:games*"
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
				"GBM_BACKEND,nvidia-drm "
				"__NV_PRIME_RENDER_OFFLOAD,1 "
				"__VK_LAYER_NV_optimus,NVIDIA_only"
				"WLR_DRM_NO_ATOMIC,1"
				"LIBGL_ALWAYS_SOFTWARE,1 # Warning. May cause hyprland to crash"
				"WLR_RENDERER_ALLOW_SOFTWARE,1"
				"MOZ_DISABLE_RDD_SANDBOX,1"
				"EGL_PLATFORM,wayland"
				"GDK_SCALE,1 "
				"HYPRCURSOR_THEME,Bibata-Modern-Ice"
				"HYPRCURSOR_SIZE,24"
				"MOZ_ENABLE_WAYLAND,1"
				];

			exec-once = [ 
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
				"swww-daemon --format xrgb && swww img ../../hosts/rakki/wallpapers/agbg.png  # persistent wallpaper"
#"$scriptsDir/Polkit-NixOS.sh"
			];

			binde = [
				"$mainMod CTRL, left, resizeactive,-50 0"
					"$mainMod CTRL, right, resizeactive,50 0"
					"$mainMod CTRL, up, resizeactive,0 -50"
					"$mainMod CTRL, down, resizeactive,0 50"
			];

			bindr = [ 
			#	"$mainMod, $mainMod_L, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window" # Super Key to Launch rofi menu
			];

			bindn = [ 
				"ALT_L, SHIFT_L, exec, $scriptsDir/SwitchKeyboardLayout.sh" # Change keyboard layout
			];

			bindm = [
				"$mainMod, mouse:272, movewindow # NOTE: mouse:272 = left click"
					"$mainMod, mouse:273, resizewindow # NOTE: mouse:272 = right click"
			];

#bindl = [
#	"bindl = , xf86AudioPlayPause, exec, $scriptsDir/MediaCtrl.sh --pause"
#	"bindl = , xf86AudioPause, exec, $scriptsDir/MediaCtrl.sh --pause"
#	"bindl = , xf86AudioPlay, exec, $scriptsDir/MediaCtrl.sh --pause"
#	"bindl = , xf86AudioNext, exec, $scriptsDir/MediaCtrl.sh --nxt "
#	"bindl = , xf86AudioPrev, exec, $scriptsDir/MediaCtrl.sh --prv"
#	"bindl = , xf86audiostop, exec, $scriptsDir/MediaCtrl.sh --stop"
#];

			bind = [ 
				"$mainMod, D, exec, pkill wofi || wofi --show drun --modi drun,filebrowser,run,window" #Main Menu
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
				"$mainMod SHIFT, O, exec, $UserScripts/ZshChangeTheme.sh" # Change oh-my-zsh theme

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

#source = [ 
#	"$HOME/.config/hypr/wallust/wallust-hyprland.conf"
#	"$HOME/.config/hypr/configs/Keybinds.conf"
#	"$HOME/.config/hypr/UserConfigs/WindowRules.conf"
#	"$HOME/.config/hypr/UserConfigs/WorkspaceRules.conf"
#	];
		};
	};
																		}
