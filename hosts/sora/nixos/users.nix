{
  pkgs,
  config,
  lib,
  ...
}: {
  users = {
    defaultUserShell = "${lib.getExe pkgs.fish}";
    mutableUsers = false;
    users = {
      rakki = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.soraPass.path;
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
      };
    };
  };
  environment.shells = with pkgs; [fish];
}
