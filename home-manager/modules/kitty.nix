{ pkgs, config, lib, nix-colors, ... }: {

	programs.kitty = {
		enable = true;
		shellIntegration.enableFishIntegration = true;
		enableGitIntegration = true;
		font.name = "JetBrainsMono Nerd Font";
		font.size = 12;
		settings = {
			shell = "${lib.getExe pkgs.fish}";
			confirm_os_window_close = 0;
			dynamic_background_opacity = true;
			enable_audio_bell = false;
			mouse_hide_wait = "3";
			window_padding_width = 4;
			# background_opacity = "0.95";
			background_blur = 2;
		};
	};
}

