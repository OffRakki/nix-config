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
      background-color = "#282828dd";
      border-color = "#3c3836ff";
      border-radius = 10;
      text-color = "#EFDECD";
      layer = "overlay";
      max-history = 50;
    };
  };
}
