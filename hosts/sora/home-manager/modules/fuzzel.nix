{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "FiraSans:size=14";
        icon-theme = "Gruvbox-Plus-Dark";
        placeholder = "Generate luminous element!";
        line-height = 24;
        width = 24;
        tabs = 2;
        horizontal-pad = 10;
        vertical-pad = 10;
        inner-pad = 10;
        image-size-ratio = 1;

        use-bold = true;
        counter = false;
        auto-select = true;
        mouse-bindings = false;
      };

      colors = {
        background = "24242cff";
        text = "be9f6eff";
        match = "be9f6eff";
        selection = "24242cff";
        selection-text = "be9f6eff";
        selection-match = "be9f6eff";
        border = "be9f6eff";
        input = "be9f6eff";
        prompt = "be9f6eff";
        counter = "be9f6eff";
      };

      border = {
        width = 2;
        radius = 4;
      };
    };
  };
}
