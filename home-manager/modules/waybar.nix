{
  lib,
  pkgs,
  config,
  ...
}:

{
  programs.waybar = lib.mkForce {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        exclusive = false;
        position = "top";
        layer = "top";

        height = 10;
        margin-top = -2;
        margin-bottom = -6;
        margin-left = 6;
        margin-right = 6;

        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
          "group/hardwaremod"
          "group/niriwindowmod"
        ];
        modules-center = [

        ];
        modules-right = [
          "group/mediamod"
          "niri/language"
          "group/clockmod"
          "group/right-icons"
          "tray"
        ];

        "group/right-icons" = {
          orientation = "horizontal";
          modules = [
            "group/audiomod"
            "network"
          ];
        };

        "cpu" = {
          interval = 5;
          format = "󰻠 {usage}%";
          tooltip = true;
          tooltip-format = "{avg_frequency}";
          min-length = 6;
        };

        "memory" = {
          interval = 5;
          format = "󰍛 {used}";
          tooltip = true;
          tooltip-format = "󰍛 {total} GiB + {swapTotal} GiB Swap";
          min-length = 6;
        };

        "group/hardwaremod" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "memory"
          ];
        };

        "niri/workspaces" = {
          margin-left = 0;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            active = "󰮯";
            empty = "<span font='6'></span>";
            default = "󰊠";
            sort-by-number = true;
          };
        };

        "niri/language" = {
          format-en = "US";
          format-en-colemak_dh = "CK";
        };
        
        "hyprland/workspaces" = {
          margin-left = 0;
          active-only = false;
          all-outputs = true;
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
          persistent-workspaces = {
            "*" = 4;
          };
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            active = "󰮯";
            empty = "<span font='6'></span>";
            default = "󰊠";
            sort-by-number = true;
          };
        };

        "network" = {
          format = "{ifname}";
          format-wifi = "<span font='12'>{icon}</span>";
          format-ethernet = "󰈀";
          format-disconnected = "<span font='12'>󰣼</span>";
          icon-size = 4;
          tooltip-format = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
          format-linked = "<span font='12'>󰈀<</span>";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-ethernet = " {bandwidthUpBytes}  {bandwidthDownBytes}";
          tooltip-format-disconnected = "󰣼 Disconnected";
          max-length = 30;
          format-icons = [
            "󰣾"
            "󰣴"
            "󰣶"
            "󰣸"
            "󰣺"
          ];
          on-click = "hyprctl dispatch exec '[float; size 512 512; center] alacritty nmtui'";
        };

        "network#speed" = {
          interval = 1;
          format = "{ifname}";
          format-wifi = " {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-ethernet = " {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-disconnected = " 0.00B/s  0.00B/s";
          tooltip-format = "{ipaddr}";
          format-linked = "󰈁 {ifname} (No IP)";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-ethernet = "{ifname} 󰌘";
          tooltip-format-disconnected = "󰌙 Disconnected";
          min-length = 20;
          max-length = 24;
          on-click = "hyprctl dispatch exec '[float; size 512 512; center] kitty nmtui'";
        };

        "group/networkmod" = {
          orientation = "horizontal";
          modules = [ "network" ];
        };

        "hyprland/window#icon" = {
          format = "";
          icon = true;
          icon-size = 20;
          offscreen-css = true;
          offscreen-css-text = "(inactive)";
        };

        "hyprland/window#title" = {
          format = "{}";
          max-length = 30;
          separate-outputs = true;
          offscreen-css = true;
          offscreen-css-text = "(inactive)";
        };

        "group/windowmod" = {
          orientation = "horizontal";
          modules = [
            "hyprland/window#icon"
            "hyprland/window#title"
          ];
        };

        "niri/window#icon" = {
          format = "";
          icon = true;
          icon-size = 20;
          offscreen-css = true;
          offscreen-css-text = "(inactive)";
        };

        "niri/window#title" = {
          format = "{}";
          max-length = 30;
          separate-outputs = true;
          offscreen-css = true;
          offscreen-css-text = "(inactive)";
        };

        "group/niriwindowmod" = {
          orientation = "horizontal";
          modules = [
            "niri/window#icon"
            "niri/window#title"
          ];
        };

        "tray" = {
          icon-size = 18;
          spacing = 8;
          show-passive-items = "false";
        };

        "mpris#icon" = {
          interval = 0.5;
          format = "<span font='12'>{player_icon}</span>";
          format-paused = "<span font='12'>{status_icon}</span>";
          format-stopped = "";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          tooltip = true;
          tooltip-format = "{status_icon}  {dynamic}\nLeft Click: previous\nMid Click: Pause\nRight Click: Next";
          player-icons = {
            chromium = "";
            default = "";
            firefox = "";
            mopidy = "";
            mpv = "󰐹";
            spotify = "";
            vlc = "󰕼";
          };
          status-icons = {
            paused = "";
            playing = "";
            stopped = "";
          };
        };

        "mpris#title" = {
          interval = 0.5;
          format = "{title} - {artist}";
          format-stopped = "";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          tooltip = true;
          tooltip-format = "{status_icon}  {dynamic}\nLeft Click: previous\nMid Click: Pause\nRight Click: Next";
          status-icons = {
            paused = "";
            playing = "";
            stopped = "";
          };
          max-length = 20;
        };

        "group/mediamod" = {
          orientation = "horizontal";
          modules = [
            "mpris#icon"
            "mpris#title"
          ];
        };

        "pulseaudio#icon" = {
          format = "<span font='12'>{icon}</span>";
          format-muted = " ";
          format-icons = {
            default = [
              " "
              " "
              " "
            ];
          };
          tooltip = true;
          tooltip-format = " {volume}%\n󰍬 {format_source}";
          format-source-muted = " 󰍭";
          icon-size = 4;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
          on-click-right = "hyprctl dispatch exec '[float; size 800 512; center] pavucontrol'";
        };

        "pulseaudio#volume" = {
          format = "{volume}%";
          format-muted = "Muted";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
          on-click-right = "hyprctl dispatch exec '[float; size 800 512; center] pavucontrol'";
        };

        "group/audiomod" = {
          orientation = "horizontal";
          modules = [ "pulseaudio#icon" ];
          max-lenght = 30;
        };

        "clock#icon" = {
          format = "<span font='12'>󰸗</span>";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "clock#date" = {
          format = "{:%a %b %d %R}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };

          "actions" = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "group/clockmod" = {
          orientation = "horizontal";
          modules = [
            "clock#icon"
            "clock#date"
          ];
        };
      };
    };
    style = ''
      @define-color bg_color #1e1e2e;
      @define-color bg2_color #181825;
      @define-color text_color #b4befe;

      * {
        border: none;
        border-radius: 0.5em;
        font-family: JetBrainsMono Nerd Font;
        font-size: 12px;
        font-style: normal;
        font-weight: bold;
        min-height: 0;
      }

      /* WORKSPACES */
      #workspaces {
        background: @bg_color;
        margin: 8px 0px 8px 0px;
        padding: 0px 0px 0px 0px;
        border-radius: 8px;
        border: solid 0px #f4d9e1;
      }

      #workspaces button {
        color: @text_color;
        padding: 5px 7px 5px 5px;
        margin-left: 0em;
        margin-right: 0em;
        transition: all 0.25s ease;
      }

      #workspaces button.active {
        color: #74c7ec;
        background-color: transparent;
        border-radius: 8px;
        transition: all 0.25s ease;
      }

      #workspaces button:hover {
        background-color: @text_color;
        color: #000000;
        border-radius: 8px;
      }

      window#waybar {
        background: transparent;
      }

      /* ACTIVE WINDOW */
      #windowmod {
        background-color: @bg_color;
        padding: 4px 4px 4px 4px;
        margin: 8px 0px 8px;
      }
      #niriwindowmod {
        background-color: @bg_color;
        padding: 4px 4px 4px 4px;
        margin: 8px 0px 8px;
      }

      window#waybar.empty #windowmod,
      window#waybar.empty #window.title {
        background-color: transparent; /* make window module transparent when no windows present */
      }

      #window.icon {
        color: @bg_color;
        padding: 0px 2px 0px 2px;
        margin-right: 0px;
      }

      #window.title {
        color: @text_color;
        background-color: @bg2_color;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
      }

      /* LAYOUT */
      #language {
        background-color: @bg_color;
        color: @text_color;
        padding: 4px 4px 4px 4px;
        margin: 8px 0px 8px;
      }

      /* NETWORK */
      #networkmod {
        background-color: @bg_color;
        padding: 4px 4px 4px 4px;
      }

      #network {
        background-color: @bg_color;
        color: @text_color;
        padding: 0px 8px 0px 4px;
      }

      #network.speed {
        color: @text_color;
        background-color: #1E1E2E;
        border-radius: 8px;
        padding-left: 8px;
      }


      #right-icons {
        margin: 8px 0px 8px;
        background-color: @bg_color;
        padding: 0px 4px 0px 4px;
      }

      /* TRAY */
      #tray {
        color: @text_color;
        margin: 8px 4px 8px 4px;
        background-color: @bg_color;
        padding: 0px 4px 0px 4px;
      }
      #tray.empty {
        background-color: transparent;
      }

      /* MEDIA PLAYER */
      #mediamod {
        background-color: @bg_color;
        border-radius: 8px;
        padding: 4px 4px 4px 4px;
        margin: 8px 4px 8px 4px;
      }

      #mpris.title.stopped~#mediamod {
        background-color: transparent;
      }
  
      #mpris.empty {
        background-color: transparent;
      }
    
      #mpris.icon {
        background-color: @bg_color;
        color: @text_color;
        padding: 0px 8px 0px 4px;
      }

      #mpris.title {
        color: @text_color;
        background-color: @bg2_color;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
        margin: 1px 1px 1px 0px;
      }

      /* AUDIO */
      #audiomod {
        background-color: @bg_color;
        border-radius: 8px;
      }

      #pulseaudio.icon {
        background-color: @bg_color;
        color: @text_color;
        padding: 4px 4px 4px 4px;
      }

      #pulseaudio.volume {
        color: @text_color;
        background-color: #1E1E2E;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
        margin: 1px 1px 1px 0px;
      }

      /* HARDWARE */
      #hardwaremod {
        color: @text_color;
        background-color: @bg_color;
        padding: 1px 1px 1px 0px;
        margin: 8px 4px 8px 4px;
      }

      #cpu {
        background-color: @bg2_color;
        padding: 2px 2px 2px 2px;
        margin: 4px;
        border-radius: 8px;
      }

      #memory {
        background-color: @bg2_color;
        padding: 2px 2px 2px 2px;
        margin: 4px;
        border-radius: 8px;
      }

      /* CLOCK */
      #clockmod {
        background-color: @bg_color;
        padding: 4px 4px 4px 4px;
        margin: 8px 4px 8px 4px;
      }

      #clock.icon {
        background-color: @bg_color;
        color: @text_color;
        padding: 0px 8px 0px 4px;
      }

      #clock.date {
        color: @text_color;
        background-color: @bg2_color;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
        margin: 1px 1px 1px 0px;
      }
    '';
  };
}
