{...}: {
  # user layer (home manager)

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    # https://ghostty.org/docs/config/reference
    settings = {
      # fonts
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;

      # ui & window architecture
      window-decoration = false; # removes borders and title bars
      gtk-titlebar = false; # disables explicit GTK decoration decoration
      window-padding-x = 8;
      window-padding-y = 0;
      background-opacity = 0.9;
    };
  };
}
