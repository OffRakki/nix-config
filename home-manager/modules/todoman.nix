{config, ...}: {
  programs.todoman =  {
    enable = false;
    glob = "~/todos/*";
    extraConfig = ''
      date_format = "%d/%m/%Y"
      time_format = "%H:%M"
      humanize = True
      default_due = 0
    '';
  };
  programs.fish.interactiveShellInit = /* fish */ ''
    complete -xc todo -a '(__fish_complete_bash)'
  '';
}
