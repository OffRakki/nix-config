{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [
    "quiet"
    # "splash"
  ];
	# Uncomment if want to do GPU passthrough to a VM
  boot.extraModulePackages = [ ];
	boot.supportedFilesystems = [ "ntfs" ];

	# Fix for wireless keyboard's FN keys not working properly
	boot.extraModprobeConfig = ''
	  options hid_apple fnmode=0    
	'';

  # Set default DNS to google's # this is a fix for conectivity problems i was having from iso to system
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];
  
  hardware.graphics = {
    enable = true;
  };
}
