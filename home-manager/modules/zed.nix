# Refer to https://wiki.nixos.org/wiki/Zed
{config, lib, ...}: {
  programs.zed-editor = lib.mkDefault {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "dockerfile"
      "docker compose"
    ];
    userSettings = {
      theme = {
        mode = "system";
        dark = "gruvbox";
        light = "gruvbox";
      };
      iconThemes = {
        dark = "Catppuccin Icons";
        light = "Catppuccin Icons";
      };
      hour_format = "hour24";
      vim_mode = true;
      lsp = {
        rust-analyzer = {
          binary = {
            # path = lib.getExe pkgs.rust-analyzer;
            path_lookup = true;
          };
        };

        nix = {
          binary = {
            path_lookup = true;
          };
        };

        elixir-ls = {
          binary = {
            path_lookup = true;
          };

          settings = {
            dialyzerEnabled = true;
          };
        };
      };
    };
  };
}
