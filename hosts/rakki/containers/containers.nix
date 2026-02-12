{config, lib, ...}:{

  systemd.services = {
    podman-glance = {
      # This ensures the service is "wanted" (optional) by multi-user.target
      # instead of "required", preventing rebuild failures if it cannot start.
      wantedBy = [ "multi-user.target" ];
    };
  };
  
	virtualisation = {
    oci-containers.containers = {
      glance = {
        image = "glanceapp/glance:latest";
        ports = ["8090:8000"];
        autoStart = true;
        pull = "missing";
        volumes = [ "${config.customPaths.containerDataDir}/glance:/app/config"];
        extraOptions = [
          "--network=host"
          "--restart=on-failure"
        ];
      };
    };
	};
}
