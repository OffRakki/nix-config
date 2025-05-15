{ pkgs, lib, config, nix-colors, ... }:

{
	programs.waybar = {
		enable = true;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				margin-top = 4;
				margin-bottom = 2;
				height = 34;
				modules-left = ["custom/launcher" "group/hardware" "hyprland/workspaces"];
				modules-center = ["hyprland/window"];
				modules-right = ["mpris" "pulseaudio" "clock" "tray"];
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
				
				"group/hardware" = {
					orientation = "horizontal";
					modules = ["cpu" "memory"];
				};

				"hyprland/window" = {
					format = "{title}";
					icon = true;
					icon-size = 16;
					max-lenght = 32;
				};

				"pulseaudio" = {
					tooltip = false;
					scroll-step = 5;
					format = "{icon} {volume}%";
					format-muted = "{icon} {volume}%";
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
					format = "{dynamic}";
					dynamic-len = 32;
				};

				"clock" = {
					format = "{:%H:%M - %d/%m/%Y}";
				};

				"tray" = {
					icon-size = 18;
					spacing = 10;
					expand = "true";
				};

				"custom/launcher" = {
        	format = " ";
        	on-click = "${pkgs.wofi}/bin/wofi --show drun --modi drun,filebrowser,run,window";
        	on-click-right = "killall wofi";
				};

				"network" = {
					#interface = "wlp2*"; # (Optional) To force the use of this interface
					format-wifi = "";
					format-ethernet = "";
					tooltip-format = "{essid} ({signalStrength}%)";
					format-linked = "{ifname} ";
					format-disconnected = "⚠";
					format-alt = "{ifname}: {ipaddr}/{cidr}";
				};
			};
		};
		style = ''
			* {
				border: none;
				font-family: "JetbrainsMono Nerd Font" ;
				min-height: 10px;
			}

			#waybar {
				border-radius: 32px;
			}

			#workspaces {
				font-size: 4px;
			}

			#custom-launcher {
				font-size: 24px;
				margin-left: 10px;
			}

			#tray {
				margin-right: 10px;
			}
		'';
	}; 
}
