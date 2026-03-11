{
  pkgs,
  lib,
  ...
}: {
  services = {
    open-webui = {
      enable = true;
      host = "0.0.0.0";
      port = 8090;
      openFirewall = true;
    };
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      loadModels = [
        "llama3.1"
        "deepseek-r1:8b"
      ];
      environmentVariables = {
        OLLAMA_KEEP_ALIVE = "20s";
      };
    };
  };
}
