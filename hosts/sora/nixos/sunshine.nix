{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [moonlight-qt];

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
  };

  hardware.uinput.enable = true;

  users.users.rakki.extraGroups = ["input" "uinput" "video"];

  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';
}
