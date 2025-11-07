{ pkgs, config, lib, ... }: {
  
	stylix = lib.mkForce {
		enable = true;
		autoEnable = false;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};
		fonts = {
			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrainsMono Nerd Font Mono";
			};
		};
		targets = {
			chromium.enable = true;
			plymouth.enable = true;
		};
	};
}
