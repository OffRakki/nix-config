{ config, ...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      snapshot.max-new-file-size = "5MiB";
      user = {
        name = config.programs.git.settings.user.name;
        email = config.programs.git.settings.user.email;
      };
      ui = {
        pager = "less -FRX";
        default-command = "log";
        graph.style = "curved";
      };
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
      # template-aliases = {
      #   "format_short_commit_header(commit)" = ''
      #     separate(" ",
      #       format_short_change_id_with_hidden_and_divergent_info(commit),
      #       format_timestamp(commit_timestamp(commit)),
      #       commit.bookmarks(),
      #       commit.tags(),
      #       commit.working_copies(),
      #       if(commit.git_head(), label("git_head", "git_head()")),
      #       format_short_commit_id(commit.commit_id()),
      #       if(commit.conflict(), label("conflict", "conflict")),
      #       if(config("ui.show-cryptographic-signatures").as_boolean(),
      #         format_short_cryptographic_signature(commit.signature())),
      #     )  
      #   '';
      # };
    };
  };
}
