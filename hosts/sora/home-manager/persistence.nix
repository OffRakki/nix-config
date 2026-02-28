{
  home.persistence."/persist" = {
    directories = [
      "sync"
      "Games"
      "Tailscale"
      ".var/app/ai.moeru.airi"
      ".local/share/flatpak"
      ".local/share/Steam"
      ".local/share/TelegramDesktop"
      ".local/share/PrismLauncher"
      ".local/share/zoxide"
      ".local/share/fish"
      ".local/share/applications"
      ".local/share/keyrings"
      ".local/state/wireplumber"
      ".local/share/icons"
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
