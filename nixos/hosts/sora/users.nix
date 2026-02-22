{ pkgs, config, username, lib, ... }: {
  users = { 
    defaultUserShell = "${lib.getExe pkgs.fish}";
    mutableUsers = false;
    users = {
      rakki = {
        isNormalUser = true;
        # hashedPasswordFile = config.sops.secrets.user-password.path;
        initialPassword = "12345";
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
          "podman"
          "input"
          "uinput"
        ];
        packages = with pkgs; [
        ];
      };
    }; 

  };

  environment.shells = with pkgs; [ fish ];
}
