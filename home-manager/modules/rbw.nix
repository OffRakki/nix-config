{config, pkgs, ...}:{
  programs.rbw = {
    enable = true;
    settings = {
      lock_timeout = 300;
      pinentry = pkgs.pinentry-gnome3;
      email = "fernandomarques1505@gmail.com";
    };
  };
}
