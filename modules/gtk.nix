{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  gtk = {
    enable = true;
    gtk4.theme = null; #silence the 26.05 stateVersion warning
  };
}
