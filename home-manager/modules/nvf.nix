{ pkgs, lib, ... }: {

  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        options = {
          clipboard = "unnamed,unnamedplus";
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          autoindent = true;
          
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
        };
        enableLuaLoader = true;
        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = false;
        };
        ui = {
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          borders = {
            enable = true;
            plugins = {
              nvim-cmp= {
                enable = true;
                style = "rounded"; # “none”, “single”, “double”, “rounded”, “solid”, “shadow” or list of (string or list of string)
              };
            };
          };
        };
        utility = {
          surround.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };
          yanky-nvim.enable = false;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          go.enable = true;
          ts.enable = true;
          rust.enable = true;
          html.enable = true;
          lua.enable = true;
          markdown.enable = true;
          bash.enable = true;
          python.enable = true;
          typst.enable = true;
      	};
        autopairs.nvim-autopairs.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        filetree.neo-tree.enable = true;
        notify.nvim-notify.enable = true;
        notes.todo-comments.enable = true;
        comments.comment-nvim.enable = true;
        presence.neocord.enable = true;
        autocomplete = {
          nvim-cmp.enable = false; #conflicts with blink-cmp
          blink-cmp.enable = true;
          enableSharedCmpSources = true;
        };
        terminal = {
          toggleterm = {
          enable = true;
          lazygit.enable = true;
          };
        };
        lsp = {
          enable = true;
          lightbulb.enable = true;
          trouble.enable = true;
        };
        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
          hardtime-nvim.enable = false;
        };
        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };
      };
    };
  };
}
