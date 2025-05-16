{ pkgs, self, lib, config, ... }: {
	programs.nixvim = {
		enable = true;
		clipboard= {
			register = "unnamedplus";
			providers.wl-copy.enable = true;
		};
    globals = {
      mapleader = " ";
    };
		opts = {
			updatetime = 100; # Faster completion
			hidden = true; # Keep closed buffer open in the background
			modeline = true; # Tags such as 'vim:ft=sh'
      modelines = 100; # Sets the type of modelines
      undofile = true; # Automatically save and restore undo history
      incsearch = true; # Incremental search: show match for partly typed search command
      inccommand = "split"; # Search and replace: preview changes in quickfix list
      ignorecase = true; # When the search query is lower-case, match both lower and upper-case patterns
      smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
			termguicolors = true; # Enables 24-bit RGB color in the |TUI|

			# Line numbers
			relativenumber = true; # Relative line numbers
      number = true; # Display the absolute line number of the current line

			# Tab options
			tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
      shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
      expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
      autoindent = true; # Do clever autoindenting
		};
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;
	};
}
