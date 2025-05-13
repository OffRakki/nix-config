{ pkgs, config, lib, ... }:

{
	programs.git = lib.mkDefault {
		enable = true;
		package = pkgs.gitAndTools.gitFull;
		userName = "offrakki";
		userEmail = "fernandomarques1505@gmail.com";
		extraConfig = {
			init.defaultBranch = "main";
			credential = {
				helper = "manager";
				"https://github.com".username = "offrakki";
				credentialStore = "cache";
			};
			commit.verbose = true;
			column.ui = "auto";
		};
	};
}	
