{config, ...}:{
  programs.aerc = {
    enable = true;
    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
        idle-timeout = "300s";
        connection-timeout = "120s";
      };
    };
  };
}
