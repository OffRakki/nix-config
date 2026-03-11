{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./drivers
    ./partitions.nix
  ];

  environment.systemPackages = [
    # pkgs.zenmonitor3
  ];

  programs.corectrl.enable = true;
  services.power-profiles-daemon.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
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
        "i2c-dev"
        "i2c-piix4"
        "i915"
        "uinput"
        "ntsync"
      ];
    };
    kernelModules = [
      "kvm-amd"
      "zenpower"
    ];
    blacklistedKernelModules = ["k10temp"];
    kernelParams = [
      "amd_pstate=active"
      "quiet"
      "splash"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
    extraModulePackages = [
      config.boot.kernelPackages.zenpower
    ];
    supportedFilesystems = ["ntfs"];
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

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = {};
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  networking = {
    hostName = "sora";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ]; # Set default DNS to google's # this is a fix for conectivity problems i was having from iso to system
    useDHCP = true;
    interfaces.enp6s0.useDHCP = true;
    firewall.allowedTCPPorts = [
      25565
      4950
      4955
      4534
    ];
    firewall.allowedUDPPorts = [
      25565
      4950
      4955
      4534
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = false;
        };
      };
    };
    i2c.enable = true;
  };
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
}
