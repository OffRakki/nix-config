{
  home.persistence."/persist" = {
    directories = [
      "sync"
      "Games"
      ".local/share/Steam"
      ".local/share/TelegramDesktop"
      ".local/share/PrismLauncher"
      ".local/share/zoxide"
      ".local/share/fish"
      ".local/share/applications"
      ".local/share/keyrings"
      ".local/state/wireplumber"
      ".cache/nix-index"
      ".config/goofcord"
      ".config/spotify"
      ".config/dconf"
      ".steam"
      {
        directory = ".ssh";
        mode = "0700";
      }
    ];
  };
}
