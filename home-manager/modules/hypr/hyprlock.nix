{
  config,
  pkgs,
  lib,
  ...
}:
{

   programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        no_fade_in = false;
        disable_loading_bar = false;
        grace = 0;
        ignore_empty_input = true;
        fractional_scaling = 0;
      };
      
      # BACKGROUND
      background = [
        {
          monitor = "";
          path = "${config.wallDir}/knnw.jpg";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # TIME
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
          color = "rgba(235, 219, 178, .75)";
          font_size = 60;
          font_family = "SF Pro Display Bold";
          position = "0, -140";
          halign = "center";
          valign = "top";
        }

        # DAY-DATE-MONTH
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"'';
          color = "rgba(225, 225, 225, 0.75)";
          font_size = 16;
          font_family = "SF Pro Display Bold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }

        # LOGO
        #{
        #  monitor = "";
        #  text = " ";
        #  color = "rgba(255, 255, 255, 0.65)";
        #  font_size = 80;
        #  position = "0, 60";
        #  halign = "center";
        #  valign = "center";
        #}

        # USER
        {
          monitor = "";
          text = ''死んでください。'';
          color = "rgba(255, 255, 255, .65)";
          font_size = 16;
          font_family = "SF Pro Display Bold";
          position = "0, -70";
          halign = "center";
          valign = "center";
        }
      ];


      # INPUT FIELD
      input-field =[
        {
          monitor = "";
          size = "290, 60";
          outline_thickness = "2";
          dots_size = "0.2"; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = "0.2"; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = "true";
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(60, 56, 54, 0.35)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = "false";
          font_family = "SF Pro Display Bold";
          placeholder_text = ''<i><span foreground="##ffffff99">Generate luminous element!</span></i>'';
          hide_input = "false";
          position = "0, -140";
          halign = "center";
          valign = "center";
        }
      ]; 
    };
  };
}
