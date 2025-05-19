{ pkgs, lib, stylix, config, ... }:
  let
    stylix_bg = config.lib.stylix.colors.base00;
    stylix_fg = config.lib.stylix.colors.base0F;
  in
{
	programs.waybar = lib.mkForce {
		enable = true;
		settings = {
			mainBar = {
				position = "top";
				layer = "top";
				margin-top = 4;
				margin-bottom = 0;
				height = 34;
				modules-left = ["group/hardware"];
				modules-center = ["hyprland/workspaces"];
				modules-right = ["mpris" "pulseaudio" "clock"];
				"hyprland/workspaces" = {
          justify = "center";
					disable-scroll = true;
					show-special = false;
					special-visible-only = false;
					all-outputs = true;
					format = "{icon}";
					format-icons = {
						"active" = "🞊";
						"default" = "⭘";
					};
          window-rewrite = {
            "title<.*chrome.*>" = "";
          };
				};
				
				"group/hardware" = {
					orientation = "horizontal";
					modules = ["cpu" "memory" "network"];
          padding = 4;
          min-lenght = 70;
          interval = 5;
          justify = "center";
				};

				"hyprland/window" = {
					format = "{title}";
					icon = true;
					icon-size = 14;
					max-lenght = 32;
          justify = "center";
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
      		interval = 5;
       		format = " {}%";
       		max-length = 10;
    		};
				
    		"memory" = {
        	interval = 5;
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
          interval = 5;
          justify = "center";
					#interface = "wlp2*"; # (Optional) To force the use of this interface
					format = "↟{bandwidthUpBits} | ↡{bandwidthDownBits}";
					tooltip-format = "bandwidthTotalBits";
					format-disconnected = "⚠";
					format-alt = "{ifname}: {ipaddr}/{cidr}";
				};
			};
		};
		style = ''
			* {
        color: #ffffff;
				font-family: "JetbrainsMono Nerd Font" ;
        font-weight: bold;
        font-size: 0.98em;
        margin-right: 2px;
        margin-left: 2px;
        border-radius: 0.5em;
        padding: 0px 6px 0px 6px;
			}

			#waybar {
        background: transparent;
        border: 0px solid rgb(215,153,33);
				border-radius: 2em;
			}

			#workspaces {
        background: #${stylix_bg}; 
        border: 1px solid #${stylix_fg};
				font-size: 1.1em;
        margin: 0px;
        padding: 0px 0px 0px 0px;
			}

      #worspaces button.active {
        border: 0px solid rgb(215,153,33);
        border-radius: 0em;
        margin: 0px;
        padding: 0px 0px 0px 0px;
      }

			#custom-launcher {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
				font-size: 24px;
				margin-left: 10px;
			}

			#pulseaudio {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
			}

			#tray {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
				margin-right: 10px;
			}

      #cpu {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
      }

      #memory {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
      }

      #clock {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
      }

      #mpris {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
      }
 
      #network {
        border: 1px solid #${stylix_fg};
        background: #${stylix_bg}; 
      }
		'';
	}; 
}
