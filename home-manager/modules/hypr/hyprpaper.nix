{config, lib, ...}: {
  services.hyprpaper = lib.mkForce {
    enable = true;
    settings = {
      ipc = true;
      splash = true;
      preload = "${config.wallDir}/agbg.jpg";
      wallpaper = ", ${config.wallDir}/agbg.jpg";
    };
  };
}
