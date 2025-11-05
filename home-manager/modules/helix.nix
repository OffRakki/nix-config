{ pkgs, config, lib, ... }: {

  programs.helix = lib.mkDefault {
    enable = true;
    defaultEditor= false;
    settings = {
      theme = "base16";
      editor = {
        soft-warp.enable = true;
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        indent-guides.render = true;
        lsp.display-messages = true;
        cursor-shape = {
          normal = "block";
          inset = "bar";
          select = "underline";
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd" "nil"];
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
