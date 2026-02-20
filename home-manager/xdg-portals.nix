{config, pkgs, inputs, ...}:{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      niri.default     = [ "gtk" "gnome" ];
      hyprland.default = [ "gtk" "hyprland" ];
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
    configPackages = [
      inputs.niri.packages.${pkgs.system}.niri-unstable
    ];
  }; 
}
