{config, pkgs, lib, inputs, ...}: let

  clip-notify = inputs.ministerio.packages.${pkgs.stdenv.system}.clip-notify;

in {
  systemd.user.services.clip-notify = {
    Unit = {
      Description = "Clipboard copy notifications";
      PartOf = [config.wayland.systemd.target];
      After = [config.wayland.systemd.target];
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --watch ${lib.getExe' clip-notify "clip-notify"}";
      Restart = "on-failure";
    };
    Install.WantedBy = [config.wayland.systemd.target];
  };
}
