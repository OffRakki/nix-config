{config, pkgs, ...}:
let
  wallpaper = (
    pkgs.fetchFromGitHub {
      owner = "OffRakki";
      repo = "walls-catppuccin-mocha";
      rev = "master";
      hash = "sha256-N+MZHSRcwOldS5Ai8B3YfKquKs9oeUW/GkV1iKM5+i8=";
    } + "/solidBackground.png");
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "${wallpaper}";
      wallpaper = ", ${wallpaper}";
    };
  };
}
