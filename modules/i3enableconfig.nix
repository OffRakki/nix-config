{ pkgs, inputs, libs, config, ... }: {
	services.xserver = {
		enable = true;
		autorun = false;
		displayManager.startx.enable = true;
		windowManager.i3.enable = true;
	};
	services.displayManager = {
		defaultSession = "none+i3";
	};
	programs.dconf.enable = true;
}
