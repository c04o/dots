{
  pkgs,
  inputs,
  theme,
  ...
}: {
  # explicitly import user modules relative to this file
  imports = [
    ./gtk.nix
    ./desktop/niri.nix
    ./desktop/sunsetr.nix
    ./desktop/walker.nix
    ./desktop/waybar.nix
    ./desktop/wbg.nix
    ./terminal/btop.nix
    ./terminal/fish.nix
    ./terminal/fzf.nix
    ./terminal/ghostty.nix
    ./terminal/starship.nix
    ./dev/git.nix
    ./dev/nvf/default.nix
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
}
