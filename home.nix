{
  pkgs, # nixpkgs
  inputs, # flakes
  ... # extra args
}: {
  home = {
    username = "coni";
    homeDirectory = "/home/coni";

    # DO NOT CHANGE. this is the home-manager release version
    stateVersion = "25.05";

    # cursor theme applied to gtk
    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;

      # uncomment if issues in xwayland
      # x11.enable = true;
    };
  };
}
