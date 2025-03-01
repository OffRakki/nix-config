{ pkgs, config, lib, nix-colors, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor= true;
    extraPackages = with pkgs; [
      lua-language-server
      python311Packages.python-lsp-server
      nixd
      pkgs.vimPlugins.nvim-treesitter-parsers.hyprlang
    ];
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
	set number relativenumber
	set shiftwidth=2
	set tabstop=2
	set clipboard^=unnamed,unnamedplus
    '';
  };
}
