{pkgs, config, ...}:
{
  services.swayosd = {
    enable = true;
    stylePath = pkgs.writeText "style.css" ''
      window {
        padding: 0 1em;
        border: 10em;
        border-radius: 10em;
        background-color: rgba(1b1b1bee);
        opacity: 1;
      }

      #container {
        margin: 1em;
      }

      image {
        color: rgb(111111);
        opacity: 1;
      }
      image:disabled {
        color: rgb(333333);
        opacity: 1;
      }
      label {
        color: rgb(555555);
        opacity: 1;
      }

      progress {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background-color: rgb(1b1b1b);
        opacity: 1;
      }
      progressbar {
        min-height: 0.5em;
        border-radius: 100em;
        background-color: transparent;
        border: none;
        opacity: 1;
      }
      progressbar:disabled {
        opacity: 1;
      }

      trough {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background-color: rgb(1b1b1b);
        opacity: 1;
      }
    '';
  };
}
