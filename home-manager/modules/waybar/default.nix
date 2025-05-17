{ pkgs, lib, stylix, config, ... }:

{
	programs.waybar = lib.mkForce {
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
					show-special = false;
					special-visible-only = false;
					all-outputs = true;
					format = "{icon}";
					format-icons = {
						"active" = "⦿";
						"default" = "○";
					};
          window-rewrite = {
            "title<.*chrome.*>" = "";
          };
				};
				
				"group/hardware" = {
					orientation = "horizontal";
					modules = ["cpu" "memory"];
          padding = 4;
				};

				"hyprland/window" = {
					format = "{title}";
					icon = true;
					icon-size = 14;
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
					on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
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
				font-family: "JetbrainsMono Nerd Font" ;
        font-weight: bold;
        font-size: 0.98em;
        margin-right: 4px;
        margin-left: 4px;
			}

			#waybar {
        border: 1px solid rgb(215,153,33);
				border-radius: 2em;
			}

			#workspaces {
				font-size: 1.1em;
        margin-left: 0px;
        margin-right: 0px;
			}

      #worspaces button.active {
        border: 1px solid rgb(215,153,33);
        border-radius: 4;
        margin-left: 0px;
        margin-right: 0px;
      }

			#custom-launcher {
				font-size: 24px;
				margin-left: 10px;
			}

			#pulseaudio {
			}

			#tray {
				margin-right: 10px;
			}
		'';
	}; 
}
