{
  pkgs,
  inputs,
  ...
}: {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.forge = {
      enable = true;
      package = inputs.nix-minecraft.packages.${pkgs.system}.neoforge-1_20_1;
      jvmOpts = "-Xmx3G -Xms2G";

      serverProperties = {
        server-port = 25565;
        gamemode = "survival";
        motd = "ablubleh";
        enable-rcon = true;
        "rcon.password" = "123123";
      };
      symlinks = {
        "mods" = /home/rakki/mcServer/mods;
        "config" = /home/rakki/mcServer/config;
        "defaultconfigs" = /home/rakki/mcServer/defaultconfigs;
      };
    };
  };
}
