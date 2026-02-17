{ config, pkgs, host, username, options, lib, inputs, system, ...}:
{
  imports = [
    ./packages-fonts.nix
    ./users.nix
    ./drivers
    ./tailscale.nix
    ./containers
  ];

  # Extra Module Options
  #drivers.amdgpu.enable = true;
  #drivers.intel.enable = false;
  drivers.nvidia.enable = true;
  #drivers.nvidia-prime = { # ja definido no arquivo em si
   # enable = true;
   # intelBusID = "0@0:2:0";
   # nvidiaBusID = "1@0:0:0";
  #};
  local.hardware-clock.enable = false;

  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # Select internationalisation properties.
  i18n.defaultLocale =  "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE =          "en_US.UTF-8";
    LC_CTYPE =          "en_US.UTF-8";
    LC_ALL =            "en_US.UTF-8";
    LC_ADDRESS =        "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT =    "en_US.UTF-8";
    LC_MONETARY =       "en_US.UTF-8";
    LC_NAME =           "en_US.UTF-8";
    LC_NUMERIC =        "en_US.UTF-8";
    LC_PAPER =          "en_US.UTF-8";
    LC_TELEPHONE =      "en_US.UTF-8";
    LC_TIME =           "en_US.UTF-8";
  };
  services = {
    smartd = {
      enable = false;
      autodetect = true;
    };
  
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
  	};

    pulseaudio.enable = false; #unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;

    flatpak.enable = false;

  	blueman.enable = true;
	
  	hardware.openrgb.enable = true;
  	hardware.openrgb.motherboard = "amd";

    fwupd.enable = true;

    upower.enable = true;
  
    gnome.gnome-keyring.enable = true;
  
    #printing = {
    #  enable = false;
    #  drivers = [
        # pkgs.hplipWithPlugin
    #  ];
    #};
  
    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};
  
    #ipp-usb.enable = true;
  
  };

  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
  	enable = true;
	  cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth
  hardware = {
  	bluetooth = {
	    enable = true;
	    powerOnBoot = true;
	    settings = {
		    General = {
		      Enable = "Source,Sink,Media,Socket";
		      Experimental = true;
		    };
      };
    };
  };

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services = {
    gdm-password.enableGnomeKeyring = true;
    hyprlock = {};
  };

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 25565 4950 4955 4534 ];
  networking.firewall.allowedUDPPorts = [ 25565 4950 4955 4534 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
