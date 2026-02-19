{lib, ...}: {
  options.customPaths = {
    wallDir   = lib.mkOption { 
      type    = lib.types.path;
      default = ../hosts/sora/wallpapers;
    };
    scriptsDir = lib.mkOption {
      type     = lib.types.path;
      default  = ../hosts/sora/scripts;
    };
    homeConfigDir = lib.mkOption {
      type     = lib.types.path;
      default  = ../hosts/sora/homeConfig;
    };
    containerDataDir = lib.mkOption {
      type     = lib.types.path;
      default  = ../hosts/sora/containers/data;
    };
  };
}
