{
  pkgs,
  inputs,
  ...
}: {
  # explicitly import user modules relative to this file
  imports = [
    ./gtk.nix
    inputs.catppuccin.homeModules.catppuccin
    (inputs.import-tree ./desktop)
    (inputs.import-tree ./terminal)
    (inputs.import-tree ./dev)
  ];

  home = {
    username = "coni";
    homeDirectory = "/home/coni";
    enableNixpkgsReleaseCheck = false;
    stateVersion = "25.05";

    packages = with pkgs; [
      polkit_gnome
      alejandra
      bat
      wl-clipboard
      cliphist
      fzf
      gimp
      imv
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

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
