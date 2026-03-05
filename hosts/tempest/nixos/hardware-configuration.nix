{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./partitions.nix
  ];

  boot = {
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
    kernelPackages = pkgs.linuxPackages;
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
      kernelModules = [
        "i915"
      ];
    };
    kernelModules = ["kvm-intel"];
    kernelParams = [
      "consoleblank=60"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
    extraModulePackages = [];
    supportedFilesystems = [];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  networking = {
    hostName = "tempest";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ]; # Set default DNS to google's # this is a fix for conectivity problems i was having from iso to system
    useDHCP = true;
    interfaces.enp2s0.useDHCP = true;
    firewall.allowedTCPPorts = [
    ];
    firewall.allowedUDPPorts = [
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
        intel-compute-runtime
      ];
    };
    i2c.enable = true;
  };

  services = {
    logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
    };
  };
}
