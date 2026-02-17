{config, pkgs, ...}:
{
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [
        "nvme"  
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ "i915" "uinput" ];
    };
    kernelModules = [ "kvm-amd" ];
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "ntfs" ];
  	# Fix for wireless keyboard's FN keys not working properly
  	extraModprobeConfig = ''
  	  options hid_apple fnmode=0    
  	'';
    plymouth = {
      enable = true;
      theme = "bgrt";
      # themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  # Set default DNS to google's # this is a fix for conectivity problems i was having from iso to system
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];
  
  hardware = {
    graphics.enable = true;
    uinput.enable = true;
  };

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = { };
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };
}
