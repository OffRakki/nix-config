{pkgs, ...}: {
  programs.steam = {
    enable = true;
    # package = pkgs.inputs.millennium.steam-millennium;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      catppuccin-cursors.mochaPeach
      proton-ge-bin
    ];
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "-r"
      "237"
    ];
  };
}
