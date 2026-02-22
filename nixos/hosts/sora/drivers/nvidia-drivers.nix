{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.nvidia;
in
{
  options.drivers.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    
  hardware = {
    uinput.enable = true;
    graphics = {
    	enable = true;
    	enable32Bit = true;
  	  extraPackages = with pkgs; [
  	    libva-vdpau-driver
    	  libvdpau
    	  libvdpau-va-gl 
    	  nvidia-vaapi-driver
    	  vdpauinfo
  	    libva
   		  libva-utils	
      ];
    };
  };

  # not need on desktop
  drivers.nvidia-prime.enable = false;
  
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
      
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement= {
      enable = true;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      # needs nvidia-prime
      finegrained = false;
    };  
    dynamicBoost.enable = false; # Dynamic Boost
    nvidiaPersistenced = false;
    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;
      
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
      
    nvidiaSettings = true;
      
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
