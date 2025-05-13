{ pkgs, lib, config, nix-colors, ... }:

{
	programs.waybar = {
		enable = true;
		style = ./style.css;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 30;
				modules-left = ["hyprland/workspaces"];
				modules-center = ["hyprland/window"];
				modules-right = ["pulseaudio" "clock" "tray"];
				"hyprland/workspaces" = {
					disable-scroll = true;
					show-special = true;
					special-visible-only = false;
					all-outputs = true;
					format = "{icon}";
					#format-icons = {
					#	"1" = "";
					#	"2" = "";
					#	"3" = "";
					#	"4" = "";
					#	"5" = "";
					#	"6" = "";
					#	"7" = "";
					#	"8" = "";
					#	"9" = "";
					#	"magic" = "";
					#};
				};

				"pulseaudio" = {
					format = "{icon} {volume}%";
					format-bluetooth = "{icon} {volume}% ";
					format-muted = "";
					format-icons = {
						"headphones" = "";
						"handsfree" = "";
						"headset" = "";
					};
					on-click = "pavucontrol";
				};

				"clock" = {
					format = "{:%d.%m.%Y - %H:%M}";
					format-alt = "{:%A, %B %d at %R}";
				};

				"tray" = {
					icon-size = 14;
					spacing = 1;
				};
			};
		};
	};
}
