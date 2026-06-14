{
  config,
  pkgs,
  ...
}: let
  attachScript = pkgs.writeShellScript "opencode-attach" ''
    OPENCODE_SERVER_PASSWORD=$(cat /run/secrets/opencodeServerPassword) \
      OPENCODE_SERVER_USERNAME=rakki \
      exec ${pkgs.opencode}/bin/opencode attach http://localhost:4096
  '';
in {
  home.persistence."/persist".directories = [
    ".local/share/opencode"
    ".config/opencode"
  ];

  xdg.desktopEntries.opencode = {
    name = "Opencode";
    genericName = "AI CLI Assistant";
    comment = "Terminal-based AI coding assistant";
    exec = "${attachScript}";
    icon = "terminal";
    terminal = true;
    categories = [
      "Development"
      "ConsoleOnly"
    ];
    mimeType = ["x-scheme-handler/opencode"];
    type = "Application";
  };
  xdg.mimeApps.defaultApplications."x-scheme-handler/opencode" = "opencode.desktop";

  systemd.user.services.opencode-server = {
    Unit = {
      Description = "OpenCode Web Server";
      After = ["network.target"];
    };
    Service = {
      Type = "simple";
      Environment = "OPENCODE_SERVER_USERNAME=rakki";
      ExecStart = "${pkgs.bash}/bin/bash -c 'OPENCODE_SERVER_PASSWORD=$(cat /run/secrets/opencodeServerPassword) exec ${pkgs.opencode}/bin/opencode web --hostname 0.0.0.0 --port 4096'";
      Restart = "on-failure";
      RestartSec = "5";
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };

  programs.opencode = {
    enable = true;
    context = ./context.md;
    skills = {
      jujutsu = ./skills/jujutsu;
      nix = ./skills/nix;
      nix-refactor = ./skills/nix-refactor;
      personal-tools = ./skills/personal-tools;
    };
    tui = {
      theme = "kanagawa";
      keybinds = {
        editor_open = "alt+e";
      };
    };
    settings = {
      permission = "allow";
      autoupdate = false;
      model = "deepseek/deepseek-v4-flash";
      provider = {
        deepseek = {
          options = {
            apiKey = "{file:/run/secrets/deepseekApiKey}";
          };
        };
        ollama = {
          name = "Ollama";
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = "http://localhost:11434/v1";
          };
          models = {
            # Closest to GPT-4 logic
            "mistral-small:22b-instruct-2409-q4_K_M" = {
              name = "Mistral Small 24B (Smartest)";
              supportsTools = true;
            };
            "llama3.1" = {
              name = "llama 3.1 8B";
              supportsTools = true;
            };
          };
        };
      };
      command = {
        archive = {
          description = "Quick-save summary to Obsidian";
          agent = "vault-archivist";
          template = "Summarize this entire chat session into a beautiful markdown note and save it to the /home/rakki/sync/Obsidian/Summaries folder.";
        };
      };
    };
  };
}
