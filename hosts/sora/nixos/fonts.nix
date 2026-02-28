{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      plemoljp
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
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
}
