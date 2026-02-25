{
  programs.wofi = {
    enable = true;
    settings = {
      image_size = 64;
      columns = 1;
      allow_images = true;
      hide_scroll = true;
      no_actions = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null"; # Maybe
      run-exec_search = true;
      insensitive = true;
      matching = "multi-contains";
    };
    style = ''
      #window {
        border-radius: 0.5em;
      	background-color: #161825;
      }
      #input {
      	background-color: #181c28;
      	border-color: #666666;
      	border-radius: 0.5em;
      	color: #fefffd;
        margin: .25em 10em .25em 10em;
        font-size: 15pt;
      }
      .entry {
        margin: .1em;
        font-size: 15pt;
      }
      #entry {
      	background: transparent;
        padding: .25em;
      }
      #entry:selected {
      	outline: none;
        background: linear-gradient(90deg, #161825, #c30fd3, #8600f5);
      }
      #text {
      	color: #fefffd;
      	padding: 3px;
      	border-radius: 1rem;
      }
      #text:selected {
      	background: transparent;
      }
      image {
        margin-left: .25em;
        margin-right: .25em;
      	background: transparent;
      }
    '';
  };
}
