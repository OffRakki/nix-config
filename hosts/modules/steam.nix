{pkgs, ...}: {
  programs.steam = {
    enable = true;
    # package = pkgs.inputs.millennium.steam-millennium;
    gamescopeSession.enable = false;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      catppuccin-cursors.mochaPeach
      proton-ge-bin
    ];
  };
}
