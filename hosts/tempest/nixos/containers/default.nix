{
  imports = [
    # ./containers.nix
  ];

  networking = {
    firewall.trustedInterfaces = ["podman0"];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # systemd.services.podman-glance = {
  #   serviceConfig = {
  #     restart = "on-failure";
  #     RestartSec = 5;
  #   };
  # };
}
