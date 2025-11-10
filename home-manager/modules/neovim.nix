{ pkgs, config, lib, nix-colors, nvf, ... }: {

  programs.neovim = lib.mkDefault {
    enable = true;
    defaultEditor= false;
    extraConfig = ''
	set number relativenumber
	set shiftwidth=2
	set tabstop=2
	set clipboard^=unnamed,unnamedplus
    '';
  };
}
