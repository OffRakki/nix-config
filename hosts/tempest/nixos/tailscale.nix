{pkgs, ...}: {
  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  systemd.services.tailscale-gro-fix = {
    description = "UDP GRO warning";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -K enp2s0 rx-udp-gro-forwarding on rx-gro-list off";
      RemainAfterExit = true;
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    extraSetFlags = ["--advertise-exit-node" "--accept-dns=false"];
  };
  networking.firewall.allowedUDPPorts = [41641]; # Facilitate firewall punching
}
