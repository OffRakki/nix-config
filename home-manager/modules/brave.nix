{pkgs,...}: {
  home.packages = [pkgs.brave];

  home.persistence = {
    "/persist".directories = [".config/BraveSoftware/Brave-Browser"];
  };
}
