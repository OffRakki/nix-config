{ pkgs, config, lib, ... }: {
  
	stylix = lib.mkDefault {
		enable = true;
		autoEnable = true;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};
		fonts = {
			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrainsMono Nerd Font";
			};
		};
		# targets = {
		# 	chromium.enable      = true;
		# 	qt.enable            = true;
		# 	gtksourceview.enable = true;
		# };
	};
}
