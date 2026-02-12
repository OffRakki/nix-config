{config, pkgs, ...}:{

	virtualisation = {
    oci-containers.containers = {
      glance = {
        image = "glanceapp/glance:latest";
        ports = ["8090:8000"];
        volumes = [ "/home/rakki/containersData/glance:/app/config"];
        extraOptions = [
          "--pull=always"
          "--network=host"
          "--restart=no"
        ];
      };
    };
	};
}
