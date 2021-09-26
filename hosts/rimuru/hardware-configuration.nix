# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."nixos".device = "/dev/disk/by-uuid/2961a2a6-54b0-43df-bab5-4b02e8b19ba7";

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=4G" "mode=755" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2B35-5F2E";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/074c9623-e2f2-4455-8445-3a3444fd135f";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/074c9623-e2f2-4455-8445-3a3444fd135f";
      fsType = "btrfs";
      options = [ "subvol=data" "compress=zstd" ];
    };

  fileSystems."/dotfiles" =
    { device = "/dev/disk/by-uuid/074c9623-e2f2-4455-8445-3a3444fd135f";
      fsType = "btrfs";
      options = [ "subvol=dotfiles" "compress=zstd" ];
    };

  swapDevices = [ ];
}
