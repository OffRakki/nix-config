{pkgs, ...}: {
  home.packages = [pkgs.inputs.hytale.default];
}
