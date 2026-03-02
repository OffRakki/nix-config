{lib, ...}: {
  programs.git = lib.mkDefault {
    enable = true;
    settings = {
      core.editor = "hx";
      init.defaultBranch = "master";
      user.name = "Fernando Marques";
      user.email = "offrakki@gmail.com";
      commit.verbose = true;
      column.ui = "auto";
    };
  };
}
