{ pkgs, inputs, ...}: let

  python-packages = pkgs.python3.withPackages (
    ps:
    with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
    ]
  );

in {

  environment.systemPackages = with pkgs; [
    #gaming
    lutris
    wine
    osu-lazer-bin

    # User Packages
    kanata-with-cmd
    kanata
    waypaper
    spotify
    kdePackages.dolphin 
    ttyper
    ripgrep
    ripgrep-all
    fd
    zoxide
    xh
    zellij
    gitui
    du-dust
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
    rtx
    espanso
    neomutt
    rmpc
    mpd
    hyprpicker
    nvidia-container-toolkit
    docker
    docker-client
    bitwarden
    spotify-player
    dysk
    #todoman
    zenith-nvidia
    libvirt
    qemu
    mangohud
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
    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
    ranger
    todo

    # WM Stuff
    brave
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
    gtk-engine-murrine #for gtk themes
    hypridle
    imagemagick 
    inxi
    jq
    alacritty
    kitty
    networkmanagerapplet
    nwg-look
    nvtopPackages.full	 
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    qt5.qtbase
    qt6.qtbase
    libsForQt5.qtstyleplugins
    rofi
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    xarchiver
    yad
    yt-dlp
    hyprshot
    python-packages
  ];

  # FONTS
  fonts = { 
    packages = with pkgs; [
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-color-emoji
      material-icons
      font-awesome
      fira-code-symbols
      fira-code
      symbola
      nerd-fonts.jetbrains-mono
      nerd-fonts.comic-shanns-mono
      nerd-fonts.shure-tech-mono
      nerd-fonts.lekton
      nerd-fonts.fira-code
      nerd-fonts.inconsolata
      jetbrains-mono
      terminus_font
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["JetBrainsMono"];
      };
    };
  };

  programs.firefox.enable = true;
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
