{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    r2modman
    evince
    anki
    imv
    mpv
    obs-studio
    obsidian
    pavucontrol
    teams-for-linux
    telegram-desktop
    vesktop
    qalculate-gtk
    vlc
		warp
		xfce.thunar-volman

		# Langs
		nil

    # CLI utils
    yazi
    todo
    ranger
    libqalculate
    comma
    bc
    bottom
    brightnessctl
    cliphist
    ffmpeg
    ffmpegthumbnailer
    fzf
    git-graph
    grimblast
    htop
    ntfs3g
    mediainfo
    microfetch
    playerctl
    ripgrep
    showmethekey
    silicon
    udisks
    ueberzugpp
    unzip
    w3m
    wget
    wl-clipboard
    wtype
    yt-dlp
    zip

    # Gaming
    prismlauncher

    # Coding stuff
    nodejs
    python311
    vscode-fhs

    # WM stuff
    libnotify
    aquamarine
    hyprlang
    hyprutils

    # Other
    bemoji
    nix-prefetch-scripts
  ];
}
