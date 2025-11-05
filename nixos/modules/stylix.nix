{ pkgs, config, lib, ... }: {
  
	stylix = lib.mkForce {
		enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
		autoEnable = true;
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
		polarity = "dark"; # "dark", "light" or "either"
	};
}
