{ lib, config, pkgs, inputs, ...}:{
  systemd.user.services.caelestia = {
    Unit = {
      Description = "Caelestia Shell Service";
      BindsTo = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requesite = [ "graphical-session.target" ];
    };
    service = {
      ExecStart = "${inputs.caelestia-shell.packages.${pkgs.system}.default}/bin/caelestia shell -d";
      Restart = "on-failure";
      RestartSec = "2";
      Environment = "PATH=${pkgs.lib.makeBinPath [ pkgs.bash pkgs.coreutils ]}";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  
  programs.caelestia = {
    enable = true;
    cli = {
      enable = true;
      settings = {
        record = {
          extraArgs = [ "--audio" ];
        };
        theme = {
          enableGTK       = false;
          enableTerm      = false;
          enableHypr      = false;
          enableDiscord   = false;
          enableSpicetify = false;
          enableFuzzel    = false;
          enableBtop      = false;
          enableQt        = false;
        };
        toggles = {
          music = {
            spotify = {
              enable = true;
              match = [{ class = "spotify"; }];
              command = [ "spotify" ];
              move = true;
            };
          };
        };
      };
    };
    package = inputs.caelestia-shell.packages.${pkgs.system}.with-cli;
    settings = {
      general = {
        apps = {
          terminal = ["kitty"];
          audio    = ["pavucontrol"];
          playback = ["mpv"];
        };
        # Not working for some reason, migrated to hypridle
        
        # idle = {
        #   # lockBeforeSleep = true;
        #   inhibitWhenAudio = false;
        #   timeouts = [
        #   {
        #     timeout = 300;
        #     idleAction = "caelestia shell lock lock";
        #   }
        #   {
        #     timeout = 600;
        #     idleAction = "hyprctl dispatch dpms off";
        #     returnAction = "hyprctl dispatch dpms on";
        #   }
        #   ];
        # };
      };
      paths.wallpaperDir = "${config.customPaths.wallDir}";
      wallpaper.postHook = "echo $WALLPAPER_PATH";
      border = {
        thickness = 6;
        rounding = 12;
      };
      appearence = {
        padding.scale = 0.5;
        spacing.scale = 0.5;
        rounding.scale = 0.5;
        transparency.enabled = true;
        font = {
          family = {
            sans = "FiraSans";
            mono = "JetBrainsMonoNL Nerd Font Mono";
            material = "${pkgs.material-symbols}";
          };
          weight = "Bold";
        };
      };
      services = {
        useFahrenheit = false;
        weatherLocation = "Piracicaba";
      };
      bar = {
        status = {
          showBattery = false;
          showNetwork = false;
          showCpu     = true;
          showRam     = true;
        };
        workspaces = {
          shown = 4;
          perMonitorWorkspaces = true;
          custom = {
            Browser = " ";
            Social = " ";
            Games = " ";
            Extra = " ";
          };
        };
      };
    };
    # extraConfig = ''
        
    # '';
  };
}
