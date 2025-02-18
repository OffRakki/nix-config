{
  inputs, lib, config, pkgs, ...}: {
  
   wayland.windowManager.hyprland = {
     enable = true;
     xwayland.enable = true;
     plugins = [];
     systemd = {
     	enable = true;
	variables = ["--all"];
	};
     settings = {

     };
     extraConfig = let modifier = "SUPER";
     term = "kitty";

     in 
       ''
	dwindle {	
	 pseudotile = yes
	 preserve_split = yes
	 special_scale_factor = 0.8
	}
	master {
	 new_status = master
	 new_on_top = 1
	 mfact = 0.5
	}
	
	general {
	 resize_on_border = true
	 allow_tearing = true
	 layout = dwindle
	}
	
	input {
	 kb_layout = us
	 kb_variant =
	 kb_model =
	 kb_options =
	 kb_rules =
	 repeat_rate = 50
	 repeat_delay = 300
	 
	 sensitivity = -0.7 #mouse sensitivity
	 numlock_by_default = true
	 left_handed = false
	 follow_mouse = true
	 float_switch_override_focus = false
	 tablet {
	     	transform = 0
	 	left_handed = 0
	 }
	}
	
	misc {
	 disable_hyprland_logo = true
	 disable_splash_rendering = true
	 vfr = true
	 vrr = 2
	 mouse_move_enables_dpms = true
	 enable_swallow = true
	 swallow_regex = ^(kitty)$
	 focus_on_activate = false
	 initial_workspace_tracking = 0
	 middle_click_paste = false
	}

	#opengl {
	#  nvidia_anti_flicker = true
	#}
	
	binds {
	 workspace_back_and_forth = true
	 allow_workspace_cycles = true
	 pass_mouse_when_bound = false
	}
	
	cursor {
	 no_hardware_cursors = true
	 enable_hyprcursor = true
	 warp_on_change_workspace = 2
	 no_warps = true 
	}
	
	env = EDITOR,nvim #default editor
	env = MANPAGER,nvim +Man
	
	env = CLUTTER_BACKEND,wayland
	env = GDK_BACKEND,wayland,x11
	env = QT_AUTO_SCREEN_SCALE_FACTOR,1
	env = QT_QPA_PLATFORM,wayland;xcb
	env = QT_QPA_PLATFORMTHEME,qt5ct
	env = QT_QPA_PLATFORMTHEME,qt6ct   
	env = QT_SCALE_FACTOR,1
	env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
	env = XDG_CURRENT_DESKTOP,Hyprland
	env = XDG_SESSION_DESKTOP,Hyprland
	env = XDG_SESSION_TYPE,wayland
	
	env = QT_QUICK_CONTROLS_STYLE,org.hyprland.style
	
	env = ELECTRON_OZONE_PLATFORM_HINT,auto
	
	env = LIBVA_DRIVER_NAME,nvidia 
	env = __GLX_VENDOR_LIBRARY_NAME,nvidia
	env = NVD_BACKEND,direct 

	env = AQ_DRM_DEVICES,/dev/dri/card0
	
	env = GBM_BACKEND,nvidia-drm 

	env = __NV_PRIME_RENDER_OFFLOAD,1 
	env = __VK_LAYER_NV_optimus,NVIDIA_only
	env = WLR_DRM_NO_ATOMIC,1
	
	# FOR VM and POSSIBLY NVIDIA
	# LIBGL_ALWAYS_SOFTWARE software mesa rendering
	#env = LIBGL_ALWAYS_SOFTWARE,1 # Warning. May cause hyprland to crash
	#env = WLR_RENDERER_ALLOW_SOFTWARE,1
	
	env = MOZ_DISABLE_RDD_SANDBOX,1
	env = EGL_PLATFORM,wayland
	       
	env = GDK_SCALE,1 
	
	env = HYPRCURSOR_THEME,Bibata-Modern-Ice
	env = HYPRCURSOR_SIZE,24

	env = MOZ_ENABLE_WAYLAND,1

	# Monitor Configuration
	# See Hyprland wiki for more details
	# https://wiki.hyprland.org/Configuring/Monitors/
	# Configure your Display resolution, offset, scale and Monitors here, use `hyprctl monitors` to get the info.

	# Monitors
	monitor=DP-3,1920x1080@239.76,0x0,1
	monitor=DP-2,1920x1080@60,1920x-210,1


	# workspaces - Monitor rules
	# https://wiki.hyprland.org/Configuring/Workspace-Rules/
	#${modifier}E - Workspace-Rules 
	# See ~/.config/hypr/UserConfigs/WorkspaceRules.conf
	
	#scriptsDir = $HOME/.config/hypr/scripts
	#UserScripts = $HOME/.config/hypr/UserScripts
	
	#wallDIR=$HOME/Pictures/wallpapers
	#lock = $scriptsDir/LockScreen.sh
	#SwwwRandom = $UserScripts/WallpaperAutoChange.sh
	
	exec-once = swww-daemon --format xrgb
	exec-once = $SwwwRandom $wallDIR # random wallpaper switcher every 30 minutes 
	
	exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
	exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
	
	exec-once = $scriptsDir/Polkit.sh

	exec-once = nm-applet --indicator &
	exec-once = swaync &
	exec-once = ags &
	exec-once = blueman-applet & 
	exec-once = rog-control-center &

	exec-once = wl-paste --type text --watch cliphist store 
	exec-once = wl-paste --type image --watch cliphist store

	exec-once = $UserScripts/RainbowBorders.sh &

	exec-once = hypridle &

	exec-once = pypr &
	
	exec-once = swww-daemon --format xrgb && swww img $HOME/Pictures/wallpapers/mecha-nostalgia.png  # persistent wallpaper
	
	exec-once = $scriptsDir/Polkit-NixOS.sh
	
	# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
	
	# old animations
	
	animations {
	 enabled = yes

	 bezier = myBezier, 0.05, 0.9, 0.1, 1.05
	 bezier = linear, 0.0, 0.0, 1.0, 1.0
	 bezier = wind, 0.05, 0.9, 0.1, 1.05
	 bezier = winIn, 0.1, 1.1, 0.1, 1.1
	 bezier = winOut, 0.3, -0.3, 0, 1
	 bezier = slow, 0, 0.85, 0.3, 1
	 bezier = overshot, 0.7, 0.6, 0.1, 1.1
	 bezier = bounce, 1.1, 1.6, 0.1, 0.85
	 bezier = sligshot, 1, -1, 0.15, 1.25
	 bezier = nice, 0, 6.9, 0.5, -4.20
 
	 animation = windowsIn, 1, 5, slow, popin
	 animation = windowsOut, 1, 5, winOut, popin
	 animation = windowsMove, 1, 5, wind, slide
	 animation = border, 1, 10, linear
	 animation = borderangle, 1, 180, linear, loop #used by rainbow borders and rotating colors
	 animation = fade, 1, 5, overshot
	 animation = workspaces, 1, 5, wind
	 animation = windows, 1, 5, bounce, popin
	}

	source = $HOME/.config/hypr/wallust/wallust-hyprland.conf
	
	general {
	 border_size = 2
	 gaps_in = 4
	 gaps_out = 6
	 
	 col.active_border = $color12 
	 col.inactive_border = $color10
	}
	
	decoration {
	 rounding = 10
	        
	 active_opacity = 2.0
	 inactive_opacity = 0.9
	 fullscreen_opacity = 1.0
	
	 dim_inactive = true
	 dim_strength = 0.1
	 dim_special = 0.8
	}
	
	
	group {
	 col.border_active = $color15
	
	       groupbar {
	       	col.active = $color0
	 }
	}
	
	#$files = thunar
	#$scriptsDir = $HOME/.config/hypr/scripts
	#$UserScripts = $HOME/.config/hypr/UserScripts
	
	# rofi App launcher
	bindr = ${modifier}, ${modifier}_L, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window # Super Key to Launch rofi menu
	bind = ${modifier}, D, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window #Main Menu
	
	bind = ${modifier}CTRL, F, fullscreen, 1 # fake full screen
	
	# ags overview
	bind = ${modifier}, A, exec, pkill rofi || true && ags -t 'overview'
	
	bind = ${modifier}, Return, exec, ${term}  #terminal
	bind = ${modifier}, T, exec, $files #file manager
	
	bind = ${modifier}ALT, C, exec, $UserScripts/RofiCalc.sh # calculator (qalculate)
	
	# pyprland
	bind = ${modifier}SHIFT, Return, exec, pypr toggle term # Dropdown terminal
	bind = ${modifier}, Z, exec, pypr zoom # Toggle Desktop Zoom
	
	# User Added Keybinds
	bind = ${modifier}SHIFT, O, exec, $UserScripts/ZshChangeTheme.sh # Change oh-my-zsh theme
	bindn = ALT_L, SHIFT_L, exec, $scriptsDir/SwitchKeyboardLayout.sh # Change keyboard layout
	
	# For passthrough keyboard into a VM
	# bind = ${modifier}ALT, P, submap, passthru
	#submap = passthru
	# to unbind
	#bind = ${modifier}ALT, P, submap, reset
	#submap = reset

	# Initial boot script enable to apply initial wallpapers, theming, new settings etc.
	# suggest not to change this or delete this including deleting referrence file in ~/.config/hypr/.initial_startup_done
	# as long as the referrence file is present, this initial-boot.sh will not execute
	exec-once = $HOME/.config/hypr/initial-boot.sh

	source=$HOME/.config/hypr/configs/Keybinds.conf # Pre-configured keybinds

	source= $HOME/.config/hypr/UserConfigs/WindowRules.conf # all about Hyprland Window Rules and Layer Rules

	source= $HOME/.config/hypr/UserConfigs/UserAnimations.conf # Animation config file

	source= $HOME/.config/hypr/UserConfigs/WorkspaceRules.conf # Hyprland workspaces

       '' ;
  };
}
