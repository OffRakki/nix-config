{ pkgs, lib, config, ... }: {

  programs.wofi = {
    enable = true;
    settings = {
      image_size = 16;
      columns = 3;
      allow_images = true;
      hide_scroll = true;
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
        color: #ddc7a1;
        background: transparent;
      }

      #window {
        background: #282828;
        margin: auto;
        padding: 20px;
        border-radius: 6px;
        border: 4px solid #3c3836;
      }

      #input {
        padding: 4px;
        margin-bottom: 4px;
      }

      #outer-box {
        padding: 8px;
      }

      #img {
        margin-right: 4px;
      }

      #entry {
        padding: 4px;
      }

      #entry:selected {
        background-color: #928374;
      }

      #text {
        margin: 2px;
      }
    '';
  };
}
