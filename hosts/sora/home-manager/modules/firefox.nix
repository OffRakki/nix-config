{...}: {
  xdg.configFile = {
    "mozilla/firefox/Rakki/chrome/userChrome.css".text = ''
      #TabsToolbar { visibility: collapse !important; }
      #sidebar-panel-header {display: none;}
      #sidebar-header {display: none;}
    '';
    "mozilla/firefox/profiles.ini".text = ''
      [Profile0]
      Name=Rakki
      IsRelative=1
      Path=Rakki
      Default=1

      [General]
      StartWithLastProfile=1
      Version=2
    '';
  };
}
