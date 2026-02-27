{
  pkgs,
  lib,
  ...
}: {
  programs.git = lib.mkDefault {
    enable = true;
    settings = {
      core.editor = "hx";
      init.defaultBranch = "master";
      credential.helper = "${lib.getExe pkgs.libsecret}";
      user.name = "offrakki";
      user.email = "offrakki@gmail.com";
      commit.verbose = true;
      column.ui = "auto";
    };
  };
}
