{config, pkgs, inputs, ...}:{
   xdg.portal = {
     enable = true;
     extraPortals = [
       pkgs.xdg-desktop-portal-wlr
       pkgs.xdg-desktop-portal-gtk
       pkgs.xdg-desktop-portal-hyprland
     ];
     config.niri.default = ["gtk" "gnome"];
     config.common."org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
     configPackages = [
      inputs.niri.packages.${pkgs.system}.niri-unstable
     ];
   }; 
}
