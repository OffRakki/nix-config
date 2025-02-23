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
	    	#"HDMI-A-1,highres,1920x0,1"
		"HDMI-A-1,disable"
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

		"col.active_border" = "$color12";
		"col.inactive_border" = "$color10";
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
		rounding = 10;

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

		    "color" = "$color12";
		    "color_inactive" = "$color10";
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
		"col.border_active" = "$color15";

		groupbar = {
		    "col.active" = "$color0";
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
		"border, 1, 10, linear"
		"borderangle, 1, 180, linear, loop" #used by rainbow borders and rotating colors
		"fade, 1, 5, overshot"
		"workspaces, 1, 5, wind"
		"windows, 1, 5, bounce, popin"
		];

	    };

	    env = [ 
		"NIXOS_OZONE_WL,1"
		#"EDITOR,nvim #default editor"
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
		"$SwwwRandom $wallDIR # random wallpaper switcher every 30 minutes "
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
		"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
		"$scriptsDir/Polkit.sh"
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
		"swww-daemon --format xrgb && swww img $HOME/Pictures/wallpapers/mecha-nostalgia.png  # persistent wallpaper"
		"$scriptsDir/Polkit-NixOS.sh"
	    ];

	    bindr = [ 
		"$mainMod, $mainMod_L, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window" # Super Key to Launch rofi menu
	    ];

	    bindn = [ 
		"ALT_L, SHIFT_L, exec, $scriptsDir/SwitchKeyboardLayout.sh" # Change keyboard layout
	    ];

	    bind = [ 
		"$mainMod, D, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window" #Main Menu
		"$mainMod CTRL, F, fullscreen, 1 # fake full screen"
		"$mainMod, A, exec, pkill rofi || true && ags -t 'overview'"
		"$mainMod, Return, exec, $terminal"  #terminal
		"$mainMod, T, exec, $files" #file manager
		"$mainMod ALT, C, exec, $qalc" # calculator (qalculate)
		"$mainMod SHIFT, Return, exec, pypr toggle term" # Dropdown terminal
		"$mainMod, Z, exec, pypr zoom # Toggle Desktop Zoom"
		"$mainMod SHIFT, O, exec, $UserScripts/ZshChangeTheme.sh" # Change oh-my-zsh theme
	    ];

		# For passthrough keyboard into a VM
		# bind = $mainModALT, P, submap, passthru
		#submap = passthru
		# to unbind
		#bind = $mainModALT, P, submap, reset
		#submap = reset

	source = [ 
		"$HOME/.config/hypr/wallust/wallust-hyprland.conf"
		"$HOME/.config/hypr/configs/Keybinds.conf"
		"$HOME/.config/hypr/UserConfigs/WindowRules.conf"
		"$HOME/.config/hypr/UserConfigs/WorkspaceRules.conf"
		];
	};
    };
}
