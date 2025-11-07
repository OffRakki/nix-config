{ pkgs, config, lib, ... }: {

  programs.helix = lib.mkForce {
    enable = true;
    defaultEditor= false;
    settings = {
      theme = "gruvbox";
      editor = {
        cursorline = true;
        soft-wrap.enable = true;
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        indent-guides.render = true;
        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd" "nil"];
          auto-format = true;
          formatter.command = "alejandra";
        }
      ];
      language-server = {
        nixd = {
          command = "nixd";
        };
      };
    };
  };
}
