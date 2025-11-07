{config, lib, ...}: {
  services.hyprpaper = lib.mkForce {
    enable = true;
    settings = {
      ipc = true;
      splash = true;
      preload = "/home/rakki/Documents/nix-config/hosts/rakki/wallpapers/aesthetic.png";
      wallpaper = ", /home/rakki/Documents/nix-config/hosts/rakki/wallpapers/aesthetic.png";
    };
  };
}
