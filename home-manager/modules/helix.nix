{ pkgs, config, lib, nix-colors, nvf, ... }: {

  programs.helix = lib.mkDefault {
    enable = true;
    defaultEditor= false;
    settings = {
      theme = "base16";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };
}
