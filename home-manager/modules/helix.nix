{
  pkgs,
  lib,
  ...
}: {
  programs.helix = lib.mkForce {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.alejandra
      pkgs.nixfmt
      pkgs.marksman
    ];
    settings = {
      theme = "gruvbox";
      editor = {
        cursorline = true;
        soft-wrap.enable = true;
        color-modes = true;
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"]; # Add/remove "line-numbers" to toggle
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
          auto-format = true;
          formatter.command = "alejandra";
          language-servers = [
            "nixd"
            "nil"
            "colors"
          ];
        }
        {
          name = "markdown";
          language-servers = ["marksman"];
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
      catppuccin_mocha = {
        "inherits" = "gruvbox";
        "ui.background" = {};
      };
    };
  };
}
