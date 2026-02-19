{config, pkgs, ...}:{
 services.flameshot = {
   enable = true;
   package = pkgs.flameshot.override { enableWlrSupport = true; };
   settings = {
     General = {
      useGrimAdapter = true;
      disabledGrimWarning = true;
      showStartupLaunchMessage = false;
      
      savePath = "${config.home.homeDirectory}/Pictures/screenshots";
      savePathFixed = true;
      
      uiColor = "#24242C";
      contrastUiColor = "#ffffff";

      copyPathAfterSave = false;
      filenamePattern = "screenshot_%Y-%m-%d_%H-%M-%S";

      drawThickness = 3;
      drawColor = "#ff0000";
     };
   };
 };
}
