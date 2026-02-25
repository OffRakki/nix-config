{
  pkgs,
  osConfig,
  ...
}: {
  systemd.user.services = {
    rclone-onedrive-mount = {
      Unit = {
        Description = "RClone OneDrive Mount";
        After = ["sops-nix.service"];
      };

      Service = {
        Type = "simple";

        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/Onedrive";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount onedrive: %h/Onedrive \
            --config=${osConfig.sops.templates."rclone-onedrive.conf".path} \
            --vfs-cache-mode full \
            --vfs-cache-max-age 24h \
            --vfs-cache-max-size 32G \
        '';

        # Proper unmount on stop
        ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/Onedrive";
        Restart = "on-failure";
        RestartSec = "10s";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
