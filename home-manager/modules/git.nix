{ pkgs, config, lib, ... }:

{
	programs.git = lib.mkDefault {
		enable = true;
		package = pkgs.gitAndTools.gitFull;
		userName = "offrakki";
		userEmail = "fernandomarques1505@gmail.com";
		extraConfig = {
			init.defaultBranch = "main";
			credential.helper = "libsecret";
			user.name = "offrakki";
			user.email = "fernandomarques1505@gmail.com";
			commit.verbose = true;
			column.ui = "auto";
		};
	};
}	
