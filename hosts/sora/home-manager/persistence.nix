{
  home.persistence."/persist".directories = [
    "sync"
    "Games"
    "Tailscale"
    ".nv"
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
    ".config/goofcord"
    ".config/spotify"
    ".config/dconf"
    ".config/noctalia"
    ".config/OpenRGB"
    ".cache/nix-index"
    ".steam"
    {
      directory = ".ssh";
      mode = "0700";
    }
  ];
}
