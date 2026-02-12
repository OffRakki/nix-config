{config, ...}: {
  services.glance = {
    enable = true;
    settings = {
      pages = [
        {
          columns = [
            {
              size = "small";
            }
          ];
        }
      ];
      name = "Dashboard";
    };
  };
}
