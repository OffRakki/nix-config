{ pkgs, username, lib, ... }:

{
  users = { 
    defaultUserShell = "${lib.getExe pkgs.fish}";
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
          "audio"
          "docker"
          "input"
          "uinput"
        ];

        packages = with pkgs; [
        ];
      };
    }; 

  };

  environment.shells = with pkgs; [ fish ];
  environment.systemPackages = with pkgs; [
    fzf
  ]; 
}
