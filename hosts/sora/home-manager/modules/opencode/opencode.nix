{config, ...}: {
  xdg.desktopEntries.opencode = {
    name = "Opencode";
    genericName = "AI CLI Assistant";
    comment = "Terminal-based AI coding assistant";
    exec = "opencode";
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

  programs.opencode = {
    enable = true;
    context = ./context.md;
    tui = {
      theme = "system";
      keybinds = {
        editor_open = "alt+e";
      };
    };
    settings = {
      autoupdate = false;
      model = "Deepseek V4 Flash";
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
