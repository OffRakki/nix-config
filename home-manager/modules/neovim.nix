{ pkgs, config, lib, nix-colors, nvf, ... }: {

  programs.neovim = lib.mkDefault {
    enable = true;
    defaultEditor= true;
    extraConfig = ''
	set number relativenumber
	set shiftwidth=2
	set tabstop=2
	set clipboard^=unnamed,unnamedplus
    '';
  };
}
