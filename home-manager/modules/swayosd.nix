{pkgs, config, lib, ...}:
{
  services.swayosd = lib.mkForce {
    enable = true;
    stylePath = pkgs.writeText "style.css" ''
      window {
        padding: 0 1em;
        border: 10em;
        border-radius: 10em;
        background-color: rgba(000000);
        opacity: 0.8;
      }
      #container {
        margin: 1em;
      }

      image {
        color: rgb(ffffff);
        opacity: 0.9;
      }
      image:disabled {
        color: rgb(999999);
        opacity: 0.8;
      }
      label {
        color: rgb(222222);
        opacity: 1;
      }

      progress {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background-color: rgb(dddddd);
        opacity: 0.9;
      }
      progressbar {
        min-height: 0.5em;
        border-radius: 100em;
        background-color: transparent;
        border: none;
        opacity: 0.9;
      }
      progressbar:disabled {
        opacity: 0.5;
      }

      trough {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background-color: rgb(aaaaaa);
        opacity: 1;
      }
    '';
  };
}
