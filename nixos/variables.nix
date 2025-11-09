{lib, ...}: {
  options = {
    wallDir = lib.mkOption {
      type = lib.types.path;
      default = ../hosts/rakki/wallpapers;
    };
  };
}
