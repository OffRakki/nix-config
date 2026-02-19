{config, pkgs, inputs, ...}:{
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
      # Ensure wayland environment variables are available
      Environment = "PATH=${pkgs.lib.makeBinPath [ pkgs.bash pkgs.coreutils ]}";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  
  programs.caelestia = {
    enable = true;
    cli.enable = true;
    package = inputs.caelestia-shell.packages.${pkgs.system}.with-cli;
    settings = {
      theme.applyGTK = false;
      paths.wallpaperDir = "${config.customPaths.wallDir}";
      appearence = {
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
        };
        workspaces = {
          perMonitorWorkspaces = false;
        };
      };
    };
    # extraConfig = ''
        
    # '';
  };
}
