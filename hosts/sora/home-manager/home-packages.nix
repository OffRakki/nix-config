{pkgs, ...}: {
  home.packages = with pkgs; [
    quickshell
    kdePackages.qttools
    lm_sensors
    r2modman
    evince
    anki
    imv
    mpv
    obsidian
    pavucontrol
    teams-for-linux
    telegram-desktop
    vesktop
    qalculate-gtk
    vlc
    warp
    lxqt.pcmanfm-qt
    foot
    swaybg
    onlyoffice-desktopeditors
    onlyoffice-documentserver

    # Langs
    nil

    # CLI utils
    satty
    flatpak
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
