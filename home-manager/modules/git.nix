{ pkgs, config, lib, ... }:

{
	programs.git = lib.mkDefault {
		enable = true;
		package = pkgs.gitAndTools.gitFull;
		settings = {
			core.editor = "nvim";
			init.defaultBranch = "master";
			credential.helper = "libsecret";
			user.name = "offrakki";
			user.email = "fernandomarques1505@gmail.com";
			commit.verbose = true;
			column.ui = "auto";
		};
	};
}	
