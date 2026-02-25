{
  programs.wofi = {
    enable = true;
    settings = {
      image_size = 64;
      columns = 3;
      allow_images = true;
      hide_scroll = true;
      no_actions = true;
      run-always_parse_args = true;
      # run-cache_file = "/dev/null"; # Maybe
      run-exec_search = true;
      insensitive = true;
      matching = "multi-contains";
    };
    style = ''
      * {
        font-family: FiraSans;
        font-size: 14px;
        color: #b4befe;
        background: transparent;
      }

      #window {
        background: #1e1e2e;
        padding: 20px;
        border-radius: 6px;
        border: 4px solid #3c3836;
      }

      #input {
        padding: 4px;
        margin-bottom: 10px;
      }

      #outer-box {
        padding: 8px;
      }

      #img {
        margin-right: 0px;
        margin-bottom: 8px;
        halign: center;
      }

      #entry {
        padding: 10px;
      }

      #entry box {
        orientation: vertical;
      }

      #inner-box {
        orientation: vertical;
      }

      #entry:selected {
        background-color: #181825;
        border-radius: 8px
      }

      #text {
        text-align: center;
        halign: center;
      }
    '';
  };
}
