{config, ...}:
let
  syncDir = "/home/rakki/sync";
in {
  services.syncthing = {
    enable = true;
    user = "rakki";
    dataDir = syncDir;
    cert = config.sops.secrets.syncthing_cert.path;
    key = config.sops.secrets.syncthing_key.path;
    openDefaultPorts = true;
    settings = {
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        "shiro" = { id = "IHSH3FE-EF36SEW-KKWASQM-7MKQTJO-AO46UT2-JR4JGQV-ISEAPWW-AK3KVQX"; };
      };
      folders = {
        "geral" = {
          path = "${syncDir}/geral";
          devices = [ "shiro" ];
        };
        "sops" = {
          path = "${syncDir}/sops";
          devices = [ "shiro" ];
        };
      };
    };
  };
}
