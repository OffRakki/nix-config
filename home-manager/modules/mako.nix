{config, ...}: {
  services.mako = {
    enable = true;
    settings = {
      font = "FiraSans";
      padding = "10,20";
      anchor = "top-center";
      width = 400;
      height = 150;
      border-size = 2;
      default-timeout = 12000;
      background-color = "#1e1e2edd";
      border-color = "#b4befeff";
      border-radius = 10;
      text-color = "#b4befe";
      layer = "overlay";
      max-history = 50;
    };
  };
}
