{
  pkgs,
  inputs,
  theme,
  ...
}: {
  config.flake.modules.homeManager.coni = {
    home = {
      username = "coni";
      homeDirectory = "/home/coni";
      enableNixpkgsReleaseCheck = false;
      stateVersion = "25.05";

      sessionVariables = {
        GTK_THEME = theme.gtk.themeName;
      };

      pointerCursor = {
        gtk.enable = true;
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };

      packages = with pkgs; [
        alejandra
        bat
        cliphist
        eza
        fastfetch
        fzf
        gimp
        imv
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
        inkscape
        lazygit
        libreoffice
        mpv
        pavucontrol
        protonup-rs
        ripgrep
        yazi
        zathura
      ];
    };

    programs.home-manager.enable = true;

    gtk = {
      enable = true;
      theme = {
        name = theme.gtk.themeName;
        package = pkgs.everforest-gtk-theme;
      };
    };
  };
}
