{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        on_unlock_cmd = "rm -f /tmp/session.lock";
      };
    };
  };
}
