{pkgs, ...}: let
  modelsPath = "/home/rakki/Opencode/Models";
in {
  services = {
    open-webui = {
      enable = false;
      port = 8090;
    };
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      models = "${modelsPath}";
      loadModels = [
        "tinyllama"
        "llama3.1"
        "qwen2.5-coder:14b"
        "deepseek-r1:8b"
        "mistral-small:22b-instruct-2409-q4_K_M"
      ];
      environmentVariables = {
        OLLAMA_KEEP_ALIVE = "120s";
      };
    };
  };
}
