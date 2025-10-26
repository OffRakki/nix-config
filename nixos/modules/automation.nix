{pkgs, lib, ... }: {

    # Automatic update
  system.autoUpgrade = {
	  enable = true;
	  dates = "weekly";
  };

    # Automatic cleanup
  nix = {
	  settings.auto-optimise-store = true;
	  gc = {
	    automatic = true;
	    dates = "daily";
	    options = "--delete-older-than 7d";
	  };
  };
}
