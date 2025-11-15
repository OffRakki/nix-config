{config, pkgs, lib, ...}:{

  home.packages = [
    (pkgs.steam.override {extraPkgs = p: [p.gamescope];})
    pkgs.gamescope
    pkgs.protontricks
  ];
}
