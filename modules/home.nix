{
  pkgs,
  inputs,
  theme,
  ...
}: {
  # explicitly import user modules relative to this file
  imports = [
    ./gtk.nix
    (inputs.import-tree ./desktop)
    (inputs.import-tree ./terminal)
    (inputs.import-tree ./dev)
  ];

  home = {
    username = "coni";
    homeDirectory = "/home/coni";
    enableNixpkgsReleaseCheck = false;
    stateVersion = "25.05";

    sessionVariables = {
      GTK_THEME = theme.gtk.themeName;
    };

    packages = with pkgs; [
      polkit_gnome
      alejandra
      bat
      wl-clipboard
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
      nautilus
      pavucontrol
      protonup-rs
      ripgrep
      yazi
      zathura
      # fonts
      inter
      nerd-fonts.jetbrains-mono
    ];
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
