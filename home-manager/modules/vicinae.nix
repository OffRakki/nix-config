{config, pkgs, ...}: {
  programs.vicinae = {
    enable = true;
    package = pkgs.inputs.nixpkgs-latest.vicinae;
  };
}
