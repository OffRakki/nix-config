{...}: {
  services.hypridle = {
    enable = false;
    settings = {
      general = {
        on_unlock_cmd = "rm -f /tmp/session.lock";
      };
    };
  };
}
