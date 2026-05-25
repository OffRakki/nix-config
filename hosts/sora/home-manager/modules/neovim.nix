{lib, ...}: {
  programs.neovim = lib.mkDefault {
    enable = true;
    withRuby = true;
    withPython3 = true;
    defaultEditor = false;
    extraConfig = ''
      set number relativenumber
      set shiftwidth=2
      set tabstop=2
      set clipboard^=unnamed,unnamedplus
    '';
  };
}
