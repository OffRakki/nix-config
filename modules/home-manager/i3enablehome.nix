{ pkgs, libs, config, inputs, ...}: {
	xsession.windowManager.i3 = {
		enable = true;
		package = pkgs.i3-gaps;
		config = {
			modifier = "Mod4";
			gaps = {
				inner = 10;
				outer = 5;
			};
		};
	};
}
