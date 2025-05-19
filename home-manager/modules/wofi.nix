{ pkgs, config, lib, ... }: {

  programs.wofi = {
    enable = true;
    settings = {
      image_size = 20;
      allow_images = true;
    };
    style = ''
      window {
      margin: 0px;
      border: 1px solid #bd93f9;
      }
      
      #input {
      margin: 5px;
      border: none;
      }
      
      #inner-box {
      margin: 5px;
      border: none;
      }
      
      #outer-box {
      margin: 5px;
      border: none;
      }
      
      #scroll {
      margin: 0px;
      border: none;
      }
      
      #text {
      margin: 5px;
      border: none;
      } 
      
      #entry.activatable #text {
      }
      
      #entry > * {
      }
      
      #entry:selected {
      }

      #entry:selected #text {
      font-weight: bold;
      }
    '';
  };
}
