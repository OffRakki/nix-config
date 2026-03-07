{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pkgs.python311
    kitty.terminfo
    ethtool
    nh
    podman-compose
    btop
    intel-gpu-tools
    nvitop
    helix
    wget
    pciutils
    usbutils
    cifs-utils
    ffmpeg-headless
    rsync
    duf
    zoxide
  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
