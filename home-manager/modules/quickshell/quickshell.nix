{config, inputs, pkgs, ...}:{
  programs.quickshell = {
    enable = true;
    systemd.enable = false;
    configs = {
    };
  };
}
