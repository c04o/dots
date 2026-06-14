{
  pkgs,
  theme,
  ...
}: {
  home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  gtk = {
    enable = true;
    gtk4.theme = null; #silence the 26.05 stateVersion warning
    theme = {
      name = theme.gtk.themeName;
      package = pkgs.everforest-gtk-theme;
    };
  };
}
