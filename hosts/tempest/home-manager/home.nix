{...}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./jujutsu.nix
    ./fastfetch.nix
    ./bat.nix
    ./eza.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "tmpst";
    homeDirectory = "/home/tmpst";
    sessionVariables = {
      NH_FLAKE = "$HOME/Documents/NixConfig";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user = {
    startServices = "sd-switch";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
