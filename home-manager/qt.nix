{pkgs, ...}:
{
  home.sessionVariables = {
    # Required for qt5, for some reason.
    QT_STYLE_OVERRIDE = "qt6ct-style";
  };
  qt = {
    enable = true;
    platformTheme = {
      name = "gtk3";
      package = [
        pkgs.libsForQt5.qtstyleplugins        

        pkgs.qt5.qtbase

        pkgs.qt6.qtbase
      ];
    };
  };
}
