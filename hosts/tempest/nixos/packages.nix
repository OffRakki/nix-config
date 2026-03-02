{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    btop
    intel-gpu-tools
    nvitop
    helix
    wget
    pciutils
    usbutils
    ffmpeg-headless
    rsync
    duf
    zoxide
  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
