{ pkgs, lib, stylix, config, ... }:

{
  programs.waybar = lib.mkForce {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        layer = "top";

        height = 16;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;

        modules-left = ["custom/launcher" "hyprland/workspaces" "group/networkmod"];
        modules-center = ["group/windowmod"];
        modules-right = ["tray" "group/mediamod" "group/audiomod" "group/clockmod" "custom/swaync"];

        "custom/launcher" = {
          format = "<span font='18'>❄️</span>";
          on-click = "wofi --show drun -G";
          on-click-right = "wofi --show run -G";
        };

        "hyprland/workspaces" = {
          active-only           = false;
          all-outputs           = true;
          disable-scroll        = false;
          on-scroll-up          = "hyprctl dispatch workspace -1";
          on-scroll-down        = "hyprctl dispatch workspace +1";
          persistent-workspaces = {
            "*" = 7;
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
          format-wifi = "<span font='14'>{icon}</span>";
          format-ethernet = "󰈀";
          format-disconnected = "<span font='14'>󰣼</span>";
          tooltip-format = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
          format-linked = "<span font='14'>󰈀<</span>";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-ethernet = "{ifname} 󰈀";
          tooltip-format-disconnected = "󰣼 Disconnected";
          max-length = 30;
          format-icons = ["󰣾" "󰣴" "󰣶" "󰣸" "󰣺"];
          on-click = "hyprctl dispatch exec '[float; size 512 512; center] kitty nmtui'";
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
          modules = ["network" "network#speed"];
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
          max-length = 25;
          separate-outputs = true;
          offscreen-css = true;
          offscreen-css-text = "(inactive)";
        };
        "group/windowmod" =  {
          orientation = "horizontal";
          modules = ["hyprland/window#icon" "hyprland/window#title"];
        };

        "tray" = {
          icon-size = 18;
          spacing = 8;
        };


        "mpris#icon" = {
          interval = 0.5;
          format = "<span font='14'>{player_icon}</span>";
          format-paused = "<span font='14'>{status_icon}</span>";
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
          modules = ["mpris#icon" "mpris#title"];
        };

        "pulseaudio#icon" = {
          format = "<span font='14'>{icon}</span>";
          format-muted = "";
          format-icons = {
            default = ["" "" ""];
          };
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
          modules = ["pulseaudio#icon" "pulseaudio#volume"];
          max-lenght = 30;
        };

        "clock#icon" = {
          format = "<span font='14'>󰸗</span>";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode           = "year";
            mode-mon-col   = 3;
            weeks-pos      = "right";
            on-scroll      = 1;
            format = {
              months =     "<span color='#ffead3'><b>{}</b></span>";
              days =       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
              today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions =    {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        "clock#date" = {
          format = "{:%a %b %d %R}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode           = "year";
            mode-mon-col   = 3;
            weeks-pos      = "right";
            on-scroll      = 1;
            format =  {
              months =     "<span color='#ffead3'><b>{}</b></span>";
              days =       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
              today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          "actions" =  {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        "group/clockmod" = {
          orientation = "horizontal";
          modules = ["clock#icon" "clock#date"];
        };

        "custom/swaync" = {
          tooltip = true;
          tooltip-format = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
          format = "{icon}";
          format-icons = {
            notification = "<span font='14'>󱅫</span>";
            none = "<span font='14'>󰂚</span>";
            dnd-notification = "<span font='14'>󰂛</span>";
            dnd-none = "<span font='14'>󰂛</span>";
            inhibited-notification = "<span font='14'>󱅫</span>";
            inhibited-none = "<span font='14'>󰂚</span>";
            dnd-inhibited-notification = "<span font='14'>󰂛</span>";
            dnd-inhibited-none = "<span font='14'>󰂛</span>";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{icon} {time}";
          # format-good = ""; # An empty format will hide the module
          # format-full = "";
          format-icons = ["" "" "" "" ""];
        };

        "memory" = {
          format = "󰍛 {}%";
          format-alt = "󰍛 {used}/{total} GiB";
          interval = 5;
        };

        "cpu" = {
          format = "󰻠 {usage}%";
          format-alt = "󰻠 {avg_frequency} GHz";
          interval = 5;
        };

        "custom/hyprpicker" = {
          format = "󰈋";
          on-click = "hyprpicker -a -f hex";
          on-click-right = "hyprpicker -a -f rgb";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0.5em;
        font-family: JetBrainsMono Nerd Font;
        font-size: 14px;
        font-style: normal;
        font-weight: bold;
        min-height: 0;
      }

      /* WORKSPACES */
      #workspaces {
        background: #1e1e2e;
        margin: 10px 8px 10px 0px;
        padding: 0px 0px 0px 0px;
        border-radius: 8px;
        border: solid 0px #f4d9e1;
      }

      #workspaces button {
        color: #f38ba8;
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
        background-color: #74c7ec;
        color: #000000;
        border-radius: 8px;
      }

      window#waybar {
        background: transparent;
      }

      #custom-launcher,
      #networkmod,
      #windowmod,
      #mediamod,
      #audiomod,
      #clockmod,
      #battery,
      #custom-swaync {
        background-color: #1e1e2e;
        margin: 8px 8px 8px 0px;
        border-radius: 8px;
      }


    
      /* LAUNCHER */
      #custom-launcher {
        color: #1e1e2e;
        background-color: #1e1e2e;
        padding: 0px 8px 0px 8px;
        margin: 8px;
      }
    
    
    

      /* NETWORK */
      #networkmod {
        background-color: #74c7ec;
        padding: 1px 1px 1px 6px;
      }

      #network {
        background-color: #74c7ec ;
        color: #1e1e2e;
        padding: 0px 12px 0px 4px;
        margin-right: 0px;
      }

      #network.speed {
        color: #74c7ec;
        background-color: #1E1E2E;
        font-size: 14px;
        border-radius: 8px;
        padding-left: 8px;
      }



      /* ACTIVE WINDOW */
      #windowmod {
        background-color: #cba6f7;
        padding: 1px 1px 1px 6px;
      }
      
      window#waybar.empty #windowmod,
      window#waybar.empty #window.title {
        background-color: transparent; /* make window module transparent when no windows present */
      }
      
      #window.icon {
        color: #1e1e2e;
        padding: 0px 6px 0px 2px;
        margin-right: 0px;
      }
      
      #window.title {
        color: #cba6f7;
        background-color: #1E1E2E;
        font-size: 14px;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
      }
      
      /* TRAY */
      #tray {
        margin: 5px 8px 5px 8px;
        padding: 0px 5px;
      }
      
      /* MEDIA PLAYER */
      #mediamod {
        background-color: #a6e3a1;
        border-radius: 8px;
      }
      
      #mpris.title.stopped~#mediamod {
        background-color: transparent;
      }
      
      #mpris.icon {
        background-color: #a7e3a1;
        color: #1e1e2e;
        padding: 0px 12px 0px 8px;
      }
      
      #mpris.title {
        color: #a6e3a1;
        background-color: #1E1E2E;
        font-size: 14px;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
        margin: 1px 1px 1px 0px;
      }
      
      /* AUDIO */
      #audiomod {
        background-color: #f38ba8;
        border-radius: 8px;
      }
      
      #pulseaudio.icon {
        background-color: #F38BA8;
        color: #1e1e2e;
        padding: 0px 12px 0px 10px;
      }
      
      #pulseaudio.volume {
        color: #f38ba8;
        background-color: #1E1E2E;
        font-size: 14px;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
        margin: 1px 1px 1px 0px;
      }
      
      /* CLOCK */
      #clockmod {
        background-color: #89b4fa;
      }
      
      #clock.icon {
        background-color: #89b4fa;
        color: #1e1e2e;
        padding: 0px 12px 0px 10px;
      }
      
      #clock.date {
        color: #89b4fa;
        background-color: #1E1E2E;
        font-size: 14px;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
        margin: 1px 1px 1px 0px;
      }
      
      /* NOTIFICATIONS */
      #custom-swaync {
        color: #1e1e2e;
        background-color: #74c7ec;
      
        padding: 0px 14px 0px 11px;
      }
      
      #custom-power {
        color: #24283b;
        background-color: #db4b4b;
        border-radius: 5px;
        margin-right: 10px;
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 0px;
        padding: 5px 10px;
      }
      
      #battery {
        color: #9ece6a;
      }

      #battery.charging {
        color: #9ece6a;
      }

      #battery.warning:not(.charging) {
        background-color: #f7768e;
        color: #24283b;
        border-radius: 5px 5px 5px 5px;
      }
    '';
  }; 
}
