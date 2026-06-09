{
  pkgs,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    groups.rakki = {};
    users = {
      root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjf4oKMc8ZFzSAJXO5YYOQM9alEUxph80pA67ePwiOA rakki@sora"
      ];
      rakki = {
        isSystemUser = true;
        group = "rakki";
      };
      tmpst = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.tmpstPass.path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjf4oKMc8ZFzSAJXO5YYOQM9alEUxph80pA67ePwiOA rakki@sora"
        ];
        extraGroups = [
          "corectrl"
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
          "render"
          "audio"
          "docker"
          "podman"
          "input"
          "uinput"
        ];
      };
    };
  };
  programs.fish.enable = true;
  environment.shells = [pkgs.fish];
}
