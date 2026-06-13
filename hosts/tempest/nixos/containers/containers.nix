{config, ...}: let
  glanceYaml = import ../../../modules/glance-dashboard.nix {
    inherit config;
    userHome = "/home/tmpst";
  };
in {
  sops = {
    secrets = {
      piholePass = {
        owner = "tmpst";
      };
      gitToken = {
        owner = "tmpst";
      };
    };
  };

  systemd.services = {
    podman-glance = {
      # This ensures the service is "wanted" (optional) by multi-user.target
      # instead of "required", preventing rebuild failures if it cannot start.
      wantedBy = ["multi-user.target"];
      restartIfChanged = true;
    };
  };

  virtualisation.oci-containers = {
    containers = {
      glance = {
        hostname = "glance";
        image = "glanceapp/glance:latest";
        autoStart = true;
        # ports = ["1201:8000"]; #ignored on host mode
        pull = "missing";
        volumes = ["${config.sops.templates."glance.yaml".path}:/app/config/glance.yml:ro"];
        extraOptions = [
          "--network=host"
          "--restart=on-failure"
        ];
      };
    };
  };

  sops.templates."glance.yaml" = {
    owner = "tmpst";
    path = "/home/tmpst/.config/glance/glance.yaml";
    content = glanceYaml;
  };
}
