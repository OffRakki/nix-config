{config, lib, ...}: {
  services.hyprpaper = lib.mkForce {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "${config.wallDir}/agbg.jpg";
      wallpaper = ", ${config.wallDir}/agbg.jpg";
    };
  };
}
