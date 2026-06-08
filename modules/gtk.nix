{
  pkgs,
  theme,
  ...
}: {
  
    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    gtk = {
      enable = true;
      theme = {
        name = theme.gtk.themeName;
        package = pkgs.everforest-gtk-theme;
      };
    };
}
