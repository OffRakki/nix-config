{ config, ...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = config.programs.git.settings.user.name;
        email = config.programs.git.settings.user.email;
      };
      ui.pager = "less -FRX";
      templates = {
        draft_commit_description = ''
          concat(
            description,
            "\n\n\n",
            indent("JJ: ", concat(
              "Change summary:\n",
              indent("     ", diff.summary()),
              "Full change:\n",
              "ignore-rest\n",
            )),
            diff.git(),
          )
        '';
      };
    };
  };
}
