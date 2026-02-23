{
  pkgs,
  config,
  ...
}: {
  services.kdeconnect = {
    enable = false;
    indicator = false;
    package = pkgs.kdePackages.kdeconnect-kde;
  };
}
