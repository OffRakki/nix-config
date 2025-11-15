{config, pkgs, inputs, ...}:{
   xdg.portal = {
     enable = true;
     extraPortals = [
       pkgs.xdg-desktop-portal-wlr
       pkgs.xdg-desktop-portal-gtk
     ];
     config.niri.default = ["gtk" "gnome"];
     configPackages = [
      inputs.niri.packages.${pkgs.system}.niri-unstable
     ];
   }; 
}
