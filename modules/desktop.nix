{
  pkgs,
  inputs,
  ...
}: let
  # Keep the theme variables context-local to the aspect that actually uses them
  themeName = "Everforest-Dark-BL";
in {
  config.flake.modules = {
    nixos.c04o = {
      # Niri, Ly display manager, and system-wide fonts go here...
      programs.niri.enable = true;
      services.displayManager.ly.enable = true;
    };

    homeManager.coni = {
      imports = [
        inputs.nvf.homeManagerModules.default
      ];

      home.sessionVariables = {
        GTK_THEME = themeName;
      };

      gtk = {
        enable = true;
        theme = {
          name = themeName;
          package = pkgs.everforest-gtk-theme;
        };
      };

      # Place all your user desktop programs here (e.g., zen-browser, gimp, inkscape, yazi)
      home.packages = [
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
        pkgs.yazi
      ];
    };
  };
}
