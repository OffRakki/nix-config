{config, pkgs, lib, ...}:{
  systemd.services = {
    ollama.serviceConfig = {
      ReadWritePaths = [ "/home/rakki/Mounts/nvme/linux/ollamaModels" ];
      BindPaths = [ 
        "/home/rakki/Mounts/nvme/linux/ollamaModels:/home/rakki/Mounts/nvme/linux/ollamaModels" 
      ];
      ProtectHome = lib.mkForce "tmpfs";
    };
    ollama-model-loader.serviceConfig = {
      ProtectHome = lib.mkForce "tmpfs";
      BindPaths = [ "/home/rakki/Mounts/nvme/linux/ollamaModels" ];
      ReadWritePaths = [ "/home/rakki/Mounts/nvme/linux/ollamaModels" ];
    };
  };
  
  services = {
    open-webui = {
      enable = false;
      port = 8000;
    };
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      models = "/home/rakki/Mounts/nvme/linux/ollamaModels";
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
