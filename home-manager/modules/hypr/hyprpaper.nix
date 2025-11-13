{config, lib, ...}: {
  services.hyprpaper = lib.mkForce {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "${config.wallDir}/blackHole.png";
      wallpaper = ", ${config.wallDir}/blackHole.png";
    };
  };
}
