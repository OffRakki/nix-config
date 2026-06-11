{
  home.persistence."/persist".directories = [
    ".config"
    ".local/share"
    {
      directory = ".ssh";
      mode = "0700";
    }
  ];
}
