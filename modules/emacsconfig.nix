{ inputs, libs, pkgs, options, config, outputs, ... }: {
	programs.emacs = {
		enable = true;
		package = pkgs.emacs
		defaultEditor = false;
		extraConfig = ''
			(setq standard-indent 2)
		'';
	};
}
