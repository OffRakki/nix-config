{
  pkgs,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users = {
      root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjf4oKMc8ZFzSAJXO5YYOQM9alEUxph80pA67ePwiOA rakki@sora"
      ];
      tmpst = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.tmpstPass.path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjf4oKMc8ZFzSAJXO5YYOQM9alEUxph80pA67ePwiOA rakki@sora"
        ];
        extraGroups = [
          "wheel"
          "networkmanager"
          "podman"
          "video"
          "render"
          "storage"
        ];
      };
    };
  };
  programs.fish.enable = true;
  environment.shells = [pkgs.fish];
}
