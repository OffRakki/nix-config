{
  inputs,
  lib,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    ./containers
    ../../modules/automation.nix
    ../../modules/fish.nix
    ../../modules/btrfs-ephemeral.nix
    ../../modules/optin-persistence.nix
    ./hardware-configuration.nix
    ./users.nix
    ./tailscale.nix
    ./packages.nix
  ];

  sops = {
    age.sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = ../../../secrets.yaml;

    secrets.tmpstPass = {
      neededForUsers = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users = {
      tmpst = import ../home-manager/home.nix;
    };
  };

  environment.sessionVariables = {
    PODMAN_COMPOSE_WARNING_LOGS = "false";
    EDITOR = "hx";
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      trusted-users = ["root" "tmpst"];
      accept-flake-config = true;
      # Enable flakes and new 'nix' command
      experimental-features = ["nix-command flakes"];
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround to get rid of the download buffer size warning
      download-buffer-size = 524288000;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
    wrappers.sudo-rs = {
      source = "${lib.getExe pkgs.sudo-rs}";
      setuid = true;
      setgid = true;
      owner = "0";
      group = "0";
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        # Opinionated: forbid root login through SSH.
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
      hostKeys = [
        {
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
    smartd = {
      enable = true;
      autodetect = true;
    };
    gvfs.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    udev.enable = true;
    dbus.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    avahi = {
      interfaces = ["enp2s0"];
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
        workstation = true;
      };
    };
  };
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };
  time.timeZone = lib.mkDefault "America/Sao_Paulo";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
