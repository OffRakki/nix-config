{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.nvidia-prime;
in
{
  options.drivers.nvidia-prime = {
    enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";
    nvidiaBusID = mkOption {
      type = types.str;
      default = "PCI:7:0:0";
    };
  };

  config = mkIf cfg.enable {
    hardware.nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # Make sure to use the correct Bus ID values for your system!
        nvidiaBusId = "${cfg.nvidiaBusID}";
      };
    };
  };
}
