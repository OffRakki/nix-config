{ pkgs, lib, config, ... }: {

  programs.wofi = {
    enable = true;
    settings = {
      image_size = 20;
      allow_images = true;
      hide_scroll = true;
      columns = 3;
      insensitive = true;
    };
    style = ''
    * {
      font-family: JetBrainsMono;
      color: #ddc7a1;
      background: transparent;
    }

    #window {
      background: #282828;
      margin: auto;
      padding: 20px;
      border-radius: 10px;
      border: 4px solid #3c3836;
    }

    #input {
      padding: 10px;
      margin-bottom: 10px;
      border-radius: 15px;
    }

    #outer-box {
      padding: 20px;
    }

    #img {
      margin-right: 6px;
    }

    #entry {
      padding: 10px;
      border-radius: 15px;
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
