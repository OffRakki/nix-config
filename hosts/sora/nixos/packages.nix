{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.kopuz.packages.${pkgs.stdenv.hostPlatform.system}.default
    # NH
    nh
    nix-output-monitor
    nvd

    # Secrets
    sops
    age

    pwvucontrol
    vulkan-tools
    floorp-bin
    lmstudio
    gollama
    gparted
    i2c-tools
    _7zip-zstd
    catppuccin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    (prismlauncher.override {
      jdks = [
        pkgs.temurin-bin-8
        pkgs.temurin-bin-17
        pkgs.temurin-bin-21
        pkgs.temurin-bin-25
      ];
    })
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
    nmap
    netcat
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
    ueberzug
    direnv
    dragon-drop
    refind
    os-prober
    nixd
    nixfmt
    tmux
    evil-helix
    # sublime
    neovim
    curl
    rofi
    kitty
    firefox
    starship
    wireplumber
    btop
    qutebrowser
    waybar-mpris
    wl-clipboard-rs
    wl-clip-persist
    clipse
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
    #gaming
    lutris
    wine
    winetricks
    protontricks
    osu-lazer-bin
    heroic

    # Containers
    podman-compose
    podman-tui
    podman-desktop

    # User Packages
    rust-paddle-ocr
    television
    dgop
    goofcord
    gdu
    ncdu
    element-desktop
    glow
    gitlogue
    vial
    abaddon
    dnd-tools
    waypaper
    spotify
    ttyper
    ripgrep-all
    fd
    zoxide
    xh
    zellij
    gitui
    dust
    dua
    hyperfine
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
    cpufrequtils
    eza
    gsettings-qt
    killall
    libappindicator
    openssl
    pciutils
    vim
    xdg-user-dirs
    xdg-utils
    oh-my-fish
    spicetify-cli

    # WM Stuff
    hyprpaper
    ags_1
    wl-color-picker
    wofi
    cava
    eog
    gnome-system-monitor
    grim
    gtk-engine-murrine
    inxi
    jq
    alacritty
    nwg-look
    nvitop
    pamixer
    pyprland
    libsForQt5.qtstyleplugins
    slurp
    swappy
    awww
    wallust
    wlogout
    xarchiver
    yad
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
