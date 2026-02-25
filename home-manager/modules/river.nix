{
  wayland.windowManager.river = {
    enable = true;
    settings = {
      # Set the background color
      background-color = "0x002b36";

      # Define keybindings
      map = {
        normal = {
          "Super Q" = "close";
          "Super Return" = "spawn foot";
          "Super D" = "spawn wofi --show drun";
          "Super J" = "focus-view next";
          "Super K" = "focus-view previous";
        };
      };

      # Set border properties
      border-width = 2;
      "border-color-focused" = "0x93a1a1";
    };
  };
}
