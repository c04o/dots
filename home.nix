# home.nix
{
  pkgs, # nixpkgs
  inputs, # flakes
  theme,
  ... # extra args
}: {
  imports = [
    # Modular, extensible and distro-agnostic Neovim configuration framework for Nix/NixOS 
    inputs.nvf.homeManagerModules.default

    # Fast, native, feature-rich terminal emulator pushing modern features
    ./configs/ghostty.nix

    # Scrollable-tiling Wayland compositor
    ./configs/niri.nix

    # Vim text editor fork focused on extensibility and agility
    ./configs/nvf.nix

    # Automatic blue light filter for Hyprland, Niri, and everything Wayland
    ./configs/sunsetr.nix

    # Minimal, blazing fast, and extremely customizable prompt for any shell
    ./configs/starship.nix

    # Wallpaper application for Wayland compositors
    ./configs/wbg.nix

    # Z shell
    ./configs/zsh.nix
  ];

  home = {
    username = "coni";
    homeDirectory = "/home/coni";

    # DO NOT CHANGE. this is the home-manager release version
    stateVersion = "25.05";

    sessionVariables = {
      # force the theme in wayland
      GTK_THEME = theme.gtk.themeName;
    };

    # cursor theme applied to gtk
    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;

      # uncomment if issues in xwayland
      # x11.enable = true;
    };

    packages = with pkgs; [
      # Uncompromising Nix Code Formatter
      alejandra

      # Official IDE for Android (stable channel)
      android-studio

      # Cat(1) clone with syntax highlighting and Git integration
      bat

      # Monitor of resources
      btop

      # Wayland clipboard manager
      cliphist

      # Modern, maintained replacement for ls
      eza

      # Actively maintained, feature-rich and performance oriented, neofetch like system information tool
      fastfetch

      # Command-line fuzzy finder written in Go
      fzf

      # GNU Image Manipulation Program
      gimp

      # Command line image viewer for tiling window managers
      imv

      # Community-driven Nix Flake for the Zen browser
      inputs.zen-browser.packages."${pkgs.system}".default

      # Vector graphics editor
      inkscape

      # Java, Kotlin, Groovy and Scala IDE from JetBrains
      jetbrains.idea-ultimate

      # Simple terminal UI for git commands
      lazygit

      # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
      libreoffice

      # General-purpose media player, fork of MPlayer and mplayer2
      mpv

      # PulseAudio Control
      pavucontrol

      # Rust app to install and update GE-Proton for Steam, and Wine-GE for Lutris
      protonup-rs

      # Utility that combines the usability of The Silver Searcher with the raw speed of grep
      ripgrep

      # Minimal, blazing fast, and extremely customizable prompt for any shell
      starship

      # Blazing fast terminal file manager written in Rust, based on async I/O
      yazi

      # Highly customizable and functional PDF viewer
      zathura
    ];
  };

  programs = {
    # let home manager manage itself
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "c04o";
      userEmail = "166080234+c04o@users.noreply.github.com";
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = theme.gtk.themeName;
      package = pkgs.everforest-gtk-theme;
    };
  };
}
