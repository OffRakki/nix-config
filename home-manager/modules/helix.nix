{ pkgs, config, lib, ... }: {

  programs.helix = lib.mkForce {
    enable = true;
    defaultEditor= true;
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
          language-servers = ["nixd" "nil" "colors"];
          auto-format = true;
          formatter.command = "alejandra";
        }
        {
          name = "json";
        }
        {
          name = "css";
        }
        {
          name = "qml";
        }
        {
          name = "python";
        }
      ];
      language-server = {
        nixd = {
          command = "nixd";
        };
        colors.command = lib.getExe pkgs.uwu-colors;
      };
    };
    themes = {
      gruvbox = {
        "inherits" = "gruvbox";
        "ui.background" = { };
      };
    };
  };
}
