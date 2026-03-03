{
  pkgs,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = true;
    users = {
      tmpst = {
        isNormalUser = true;
        initalPssword = "123123123";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjf4oKMc8ZFzSAJXO5YYOQM9alEUxph80pA67ePwiOA rakki@igris"
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
