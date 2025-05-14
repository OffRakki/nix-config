{ pkgs, lib, config, nix-colors, ... }:

{
	programs.waybar = {
		enable = true;
		style = ./style.css;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				margin-top = 4;
				margin-bottom = 2;
				height = 34;
				modules-left = ["cpu" "memory"];
				modules-center = ["hyprland/workspaces"];
				modules-right = ["pulseaudio" "clock" "tray"];
				"hyprland/workspaces" = {
					disable-scroll = true;
					show-special = true;
					special-visible-only = false;
					all-outputs = true;
					format = "{icon}";
					format-icons = {
						"active" = "⦿";
						"default" = "○";
					};
				};

				"pulseaudio" = {
					tooltip = false;
					scroll-step = 5;
					format = "{icon} {volume}%";
					format-muted = "{icon} {volume}%";
					on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
					format-icons = {
						default = ["" "" ""];
					};
				};

				"cpu" = {
      		interval = 15;
       		format = " {}%";
       		max-length = 10;
    		};
				
    		"memory" = {
        	interval = 30;
        	format = " {}%";
        	max-length = 10;
	    	};

				"mpris" = {
					format = "exec waybar-mpris";
				};

				"clock" = {
					format = "{:%d.%m.%Y - %H:%M}";
					format-alt = "{:%A, %B %d at %R}";
				};

				"tray" = {
					icon-size = 18;
					spacing = 10;
				};
			};
		};
	};
}
