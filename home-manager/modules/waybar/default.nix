{ pkgs, lib, config, nix-colors, ... }:

{
	programs.waybar = lib.mkDefault {
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
			/*
			*
			* Catppuccin Mocha palette
			* Maintainer: rubyowo
			*
			*/
			
			@define-color base   #1e1e2e;
			@define-color mantle #181825;
			@define-color crust  #11111b;
			
			@define-color text     #cdd6f4;
			@define-color subtext0 #a6adc8;
			@define-color subtext1 #bac2de;
			
			@define-color surface0 #313244;
			@define-color surface1 #45475a;
			@define-color surface2 #585b70;
			
			@define-color overlay0 #6c7086;
			@define-color overlay1 #7f849c;
			@define-color overlay2 #9399b2;
			
			@define-color blue      #89b4fa;
			@define-color lavender  #b4befe;
			@define-color sapphire  #74c7ec;
			@define-color sky       #89dceb;
			@define-color teal      #94e2d5;
			@define-color green     #a6e3a1;
			@define-color yellow    #f9e2af;
			@define-color peach     #fab387;
			@define-color maroon    #eba0ac;
			@define-color red       #f38ba8;
			@define-color mauve     #cba6f7;
			@define-color pink      #f5c2e7;
			@define-color flamingo  #f2cdcd;
			@define-color rosewater #f5e0dc;
			/*-----------------------------------*/
			
			* {
				border: none;
				border-radius: 32px;
				font-family: "JetbrainsMono Nerd Font" ;
				font-size: 14px;
				min-height: 10px;
			}
			
			window#waybar {
				background: transparent;
			}
			
			window#waybar.empty #window {
				background: transparent;
			}
			
			window#waybar.hidden {
				opacity: 0.2;
			}
			
			#window {
				margin-top: 0px;
				padding-left: 10px;
				padding-right: 10px;
				border-radius: 10px;
				transition: all 0.3s linear;
			  color: @peach;
				background: @base;
			}
			
			#workspaces {
				margin-top: 6px;
				margin-left: 12px;
				font-size: 4px;
				margin-bottom: 0px;
				border-radius: 10px;
				background: @base;
				transition: none;
			}
			
			#workspaces button {
				transition: none;
				color: #B5E8E0;
				background: transparent;
				font-size: 16px;
				border-radius: 2px;
			}
			
			#workspaces button.occupied {
				transition: none;
				color: #F28FAD;
				background: transparent;
				font-size: 4px;
			}
			
			#workspaces button.active {
				color: @teal;
			  	border-top: 0px solid #ABE9B3;
			  	border-bottom: 0px solid #ABE9B3;
			}
			
			#workspaces button:hover {
				transition: none;
				box-shadow: inherit;
				text-shadow: inherit;
				color: @yellow;
				border-color: #E8A2AF;
				color: #E8A2AF;
			}
			
			#workspaces button.active:hover {
				color: #E8A2AF;
			}
			
			#network {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 18px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: @base;
			}
			
			#pulseaudio {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}
			
			#battery {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}
			
			@keyframes blink {
				to {
			  	background-color: @base;
			    color: @peach;
			  }
			}
			
			#mpris {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}
			#clock {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
				/*background: #1A1826;*/
			}
			
			#memory {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}
			
			#cpu {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}
			
			#tray {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}
			
			#tray.empty {
				margin-top: 0px;
				margin-left: 0px;
				padding-left: 0px;
				margin-bottom: 0px;
				padding-right: 0px;
				border-radius: 0px;
				transition: none;
				color: transparent;
				background: transparent;
			}
			
			#custom-launcher {
				font-size: 24px;
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 5px;
				border-radius: 10px;
				transition: none;
			  color: @teal;
			  background: @base;
			}
			
			#custom-power {
				font-size: 20px;
				margin-top: 6px;
				margin-left: 8px;
				margin-right: 8px;
				padding-left: 10px;
				padding-right: 5px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}

			#custom-wallpaper {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: @peach;
				background: @base;
			}
		'';
	};
}
