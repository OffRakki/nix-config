{ config, ...}:
{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "catppuccin";
      model = "openai/gpt-4.1-mini";
    };
  };
}
