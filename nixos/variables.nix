{lib, ...}: {
  options.customPaths = {
    wallDir   = lib.mkOption { 
      type    = lib.types.path;
      default = ../hosts/rakki/wallpapers;
    };
    scriptsDir = lib.mkOption {
      type     = lib.types.path;
      default  = ../hosts/rakki/scripts;
    };
    homeConfigDir = lib.mkOption {
      type     = lib.types.path;
      default  = ../hosts/rakki/homeConfig;
    };
    containerDataDir = lib.mkOption {
      type     = lib.types.path;
      default  = ../hosts/rakki/containers/data;
    };
  };
}
