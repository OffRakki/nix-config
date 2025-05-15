{ pkgs, config, lib, nix-colors, ... }: {

	programs.qutebrowser = lib.mkDefault {
		enable = true;
		settings = {
			colors = {
				webpage.preferred_color_scheme = "${config.colorScheme.variant}";
				tabs.bar.bg = "#${config.colorScheme.palette.base00}";
				keyhint.fg = "#${config.colorScheme.palette.base05}";
			};
		};    
	};
																				}
