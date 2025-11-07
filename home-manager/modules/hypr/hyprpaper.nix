{config, lib, ...}: {
  services.hyprpaper = lib.mkForce {
    enable = true;
    settings = {
      ipc = true;
      splash = true;
      preload = "${../../../hosts/rakki/wallpapers/aesthetic.png}";
      wallpaper = ", ${../../../hosts/rakki/wallpapers/aesthetic.png}";
    };
  };
}
