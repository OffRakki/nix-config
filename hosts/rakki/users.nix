# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

{
    users = { 
	defaultUserShell = "${pkgs.fish}/bin/fish";
	mutableUsers = true;
	users = {
	    rakki = {
		initialPassword = "123123123";
		isNormalUser = true;
		openssh.authorizedKeys.keys = [ ];
		extraGroups = [
		    "networkmanager"
				"storage"
		    "wheel"
				"disk"
		    "libvirtd"
				"libvirt"
				"qemu-libvirtd"
		    "scanner"
		    "lp"
		    "video" 
		    "input" 
		    "audio"
		];

		packages = with pkgs; [
		];
	    };
	}; 

    };

    environment.shells = with pkgs; [ fish ];
    environment.systemPackages = with pkgs; [ fzf ]; 
}
