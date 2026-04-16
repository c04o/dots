{theme, ...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    # https://ghostty.org/docs/config/reference
    settings = {
      # fonts
      font-family = theme.fonts.mono;
      font-size = 12;

      # ui & window
      window-decoration = false; # titlebar, borders, etc
      gtk-titlebar = false; # full gtk titlebar instead of wm's
      window-padding-x = 8;
      window-padding-y = 0;

      # set to <1.0 if you want transparency
      background-opacity = 1.0;

      # core colors
      background = theme.colors.bg0;
      foreground = theme.colors.fg;
      cursor-color = theme.colors.fg;
      selection-background = theme.colors.bg_visual;

      # https://www.ditig.com/256-colors-cheat-sheet
      palette = [
        "0=${theme.colors.bg1}" # Black (SYSTEM)
        "1=${theme.colors.red}" # Maroon (SYSTEM)
        "2=${theme.colors.green}" # Green (SYSTEM)
        "3=${theme.colors.yellow}" # Olive (SYSTEM)
        "4=${theme.colors.blue}" # Navy (SYSTEM)
        "5=${theme.colors.purple}" # Purple (SYSTEM)
        "6=${theme.colors.aqua}" # Teal (SYSTEM)
        "7=${theme.colors.fg}" # Silver (SYSTEM)
        "8=${theme.colors.grey1}" # Grey (SYSTEM)
        "9=${theme.colors.red}" # Red (SYSTEM)
        "10=${theme.colors.green}" # Lime (SYSTEM)
        "11=${theme.colors.yellow}" # Yellow (SYSTEM)
        "12=${theme.colors.blue}" # Blue (SYSTEM)
        "13=${theme.colors.purple}" # Fuchsia (SYSTEM)
        "14=${theme.colors.aqua}" # Aqua (SYSTEM)
        "15=${theme.colors.fg}" # White (SYSTEM)
      ];
    };
  };
}
