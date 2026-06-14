{
  pkgs,
  theme,
  ...
}: {
  # user layer (home manager)
  
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;

      # https://ghostty.org/docs/config/reference
      settings = {
        # fonts
        font-family = theme.fonts.mono;
        font-size = 12;

        # ui & window architecture
        window-decoration = false; # removes borders and title bars
        gtk-titlebar = false; # disables explicit GTK decoration decoration
        window-padding-x = 8;
        window-padding-y = 0;
        background-opacity = 1.0;

        # colors mapped from central theme structure
        background = theme.colors.bg0;
        foreground = theme.colors.fg;
        cursor-color = theme.colors.fg;
        selection-background = theme.colors.bg_visual;

        # 16-color anis terminal grid
        palette = [
          "0=${theme.colors.bg1}" # Black
          "1=${theme.colors.red}" # Maroon
          "2=${theme.colors.green}" # Green
          "3=${theme.colors.yellow}" # Olive
          "4=${theme.colors.blue}" # Navy
          "5=${theme.colors.purple}" # Purple
          "6=${theme.colors.aqua}" # Teal
          "7=${theme.colors.fg}" # Silver
          "8=${theme.colors.grey1}" # Grey
          "9=${theme.colors.red}" # Red
          "10=${theme.colors.green}" # Lime
          "11=${theme.colors.yellow}" # Yellow
          "12=${theme.colors.blue}" # Blue
          "13=${theme.colors.purple}" # Fuchsia
          "14=${theme.colors.aqua}" # Aqua
          "15=${theme.colors.fg}" # White
        ];
      };
    };
}
