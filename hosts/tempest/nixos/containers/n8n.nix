{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [
    88
    1204
  ];

  virtualisation.oci-containers.containers = {
    "n8n-python-runner" = {
      image = "docker.io/n8nio/runners:2.10.4";
      extraOptions = ["--network=tempest"];
      environment = {
        N8N_RUNNERS_AUTH_TOKEN = "283b2ec20d89c001cd2c7d6393e0d53976f2424977e862e5";
        N8N_RUNNER_TYPE = "python";
      };
    };

    "n8n" = {
      image = "docker.io/n8nio/n8n:2.10.4";
      dependsOn = ["n8n-python-runner"];
      ports = [
        "1204:5678"
        "88:88"
      ];
      volumes = [
        "/home/tmpst/Documents/DockerVolumes/n8n:/home/node/.n8n:z"
      ];
      extraOptions = [
        "--network=tempest"
        "--hostname=n8n"
      ];
      environment = {
        GENERIC_TIMEZONE = "America/Sao_Paulo";
        N8N_BASIC_AUTH_ACTIVE = "true";
        N8N_SECURE_COOKIE = "false";
        N8N_RUNNERS_HOST = "n8n-python-runner";
        N8N_RUNNERS_MODE = "external";
        N8N_RUNNERS_PORT = "5679";
        N8N_RUNNERS_AUTH_TOKEN = "283b2ec20d89c001cd2c7d6393e0d53976f2424977e862e5";
      };
    };
  };

  systemd.services = {
    init-podman-network = {
      description = "Create the tempest podman network";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        ${pkgs.podman}/bin/podman network inspect tempest || ${pkgs.podman}/bin/podman network create tempest
      '';
    };
  };
}
