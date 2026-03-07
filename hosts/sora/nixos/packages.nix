{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # NH
    nh
    nix-output-monitor
    nvd

    # Secrets
    sops
    age

    pomodoro-gtk
    qbittorrent-nox
    passmark-performancetest
    s-tui
    qdiskinfo
    kdiskmark
    (pkgs.nemo-with-extensions.override {
      extensions = [
        pkgs.nemo-python
        pkgs.folder-color-switcher
        pkgs.nemo-fileroller
        pkgs.nemo-emblems
        pkgs.nemo-preview
      ];
    })
    glib
    gsettings-desktop-schemas
    inputs.nuls.packages.${system}.default
    lsfg-vk
    lsfg-vk-ui
    mangohud
    mangojuice
    qt6.qtwayland
    qt5.qtwayland
    parallel-full
    # hyprpolkitagent # Using polkit from noctalia shell plugin
    qgnomeplatform-qt6
    lprint
    android-tools
    marksman
    bitwarden-cli
    libreoffice-fresh
    rclone
    rclone-browser
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    dotool
    sddm-astronaut
    sddm-sugar-dark
    appimage-run
    grc
    xwayland-satellite
    xwayland
    xwayland-run
    localsend
    fuzzel
    netplan
    jujutsu
    kdePackages.kde-cli-tools
    dialog
    freerdp
    iproute2
    libnotify
    nmap
    netcat
    hypridle
    tailscale
    nyxt
    sudo-rs
    mprime
    diffutils
    matugen
    oama
    pass
    msmtp
    uutils-coreutils-noprefix
    ueberzugpp
    ueberzug
    w3m
    direnv
    dragon-drop
    refind
    os-prober
    nixd
    nixfmt
    vulkan-tools
    nushell
    tmux
    evil-helix
    # sublime
    neovim
    wget
    curl
    rofi
    kitty
    firefox
    starship
    fastfetch
    wireplumber
    pwvucontrol
    pipecontrol
    btop
    qutebrowser
    vesktop
    waybar-mpris
    wl-clipboard-rs
    wl-clip-persist
    clipse
    fzf
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
    #gaming
    lutris
    wine
    osu-lazer-bin
    heroic

    # Containers
    podman-compose
    podman-tui
    podman-desktop

    # User Packages
    rust-paddle-ocr
    television
    silicon
    dgop
    goofcord
    imagemagick
    gdu
    ncdu
    element-desktop
    glow # Render markdown files on terminal
    gitlogue # Screen protection with git logs animated
    vial
    abaddon
    duf
    dnd-tools
    waypaper
    spotify
    ttyper
    ripgrep
    ripgrep-all
    fd
    zoxide
    xh
    zellij
    gitui
    dust
    dua
    hyperfine
    evil-helix
    bacon
    cargo-info
    fselect
    ncspot
    rusty-man
    delta
    tokei
    wiki-tui
    just
    mask
    mprocs
    presenterm
    kondo
    mise
    espanso
    neomutt
    rmpc
    mpd
    hyprpicker
    nvidia-container-toolkit
    docker
    docker-client
    bitwarden-desktop
    spotify-player
    dysk
    #todoman
    zenith-nvidia
    libvirt
    qemu
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    eza
    ffmpeg
    glib
    gsettings-qt
    killall
    libappindicator
    libnotify
    openssl
    pciutils
    vim
    wget
    xdg-user-dirs
    xdg-utils
    fastfetch
    oh-my-fish
    spicetify-cli
    mpv
    ranger
    todo

    # WM Stuff
    hyprpaper
    ags_1 # desktop overview
    wl-color-picker
    wofi
    btop
    brightnessctl # for brightness control
    cava
    cliphist
    eog
    gnome-system-monitor
    grim
    gtk-engine-murrine # for gtk themes
    hypridle
    imagemagick
    inxi
    jq
    alacritty
    kitty
    nwg-look
    nvitop
    pamixer
    pavucontrol
    playerctl
    pyprland
    libsForQt5.qtstyleplugins
    rofi
    slurp
    swappy
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    xarchiver
    yad
    yt-dlp
    hyprshot
  ];

  programs.nm-applet.indicator = true;
  programs.virt-manager.enable = true;
  programs.seahorse.enable = true;
  programs.fuse.userAllowOther = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Extra Portal Configuration
}
