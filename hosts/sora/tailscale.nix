{lib, ...}: {
  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };
  
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
  };
  networking.firewall.allowedUDPPorts = [41641]; # Facilitate firewall punching
}
