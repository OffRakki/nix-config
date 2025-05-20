{ pkgs, config, lib, ... }: {
  
	stylix = lib.mkForce {
		enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
		autoEnable = true;
	  image = ../../hosts/rakki/wallpapers/tokyo-night.png;
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
