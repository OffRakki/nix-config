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
          "docker"
        ];

        packages = with pkgs; [
        ];
      };
    }; 

  };

  environment.shells = with pkgs; [ fish ];
  environment.systemPackages = with pkgs; [ fzf ]; 
}
