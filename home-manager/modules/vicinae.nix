{config, pkgs, ...}: {
  programs.vicinae = {
    enable = true;
    package = pkgs.vicinae;
  };
}
