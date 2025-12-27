{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "c04o";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Managua";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = false;

  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = false;

  programs.niri.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.coni = {
    isNormalUser = true;
    description = "coni";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    interactiveShellInit = ''
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh

      unalias f 2>/dev/null
      f() {
        fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' \
            --bind 'enter:become(nvim {})' \
            --bind 'alt-c:execute-silent(cat {} | wl-copy)+abort' \
            --bind 'alt-p:execute-silent(echo -n {} | wl-copy)+abort' \
            --header $'Enter \033[33m\033[0m • Alt-C \033[33m󰆏\033[0m • Alt+P \033[33m\033[0m' \
            --layout=reverse --border
      }

      y() {
        # If no argument is passed, print usage
        if [ -z "$1" ]; then
          echo "Usage: y <filename>"
          return 1
        fi
        
        # Copy file content to clipboard
        cat "$1" | wl-copy
	echo -e "\033[32m  Copied content of $1 to clipboard\033[0m"
      }
    '';

    shellAliases = {
      # System & tools
      c = "clear";
      v = "nvim";
      b = "bat";
      ff = "fastfetch";
      r = "rm -I";
      rf = "rm -rf";
      rb = "sudo nixos-rebuild switch --flake .";

      # Dir nav
      ".." = "cd ..";
      "..." = "cd ../..";
      l = "ls -l";
      ll = "ls -la";

      # Git basics
      g = "git";
      lg = "lazygit";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push";
      gpo = "git push -u origin HEAD";
      gl = "git pull";
      gs = "git status";

      # Git branching
      gb = "git branch";
      gba = "git branch -a";
      gco = "git checkout";
      gd = "git diff";
      gst = "git stash";
      gstp = "git stash pop";
      gstl = "git stash list";
      glo = "git log --oneline --graph --decorate";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    sunsetr
    ghostty
    psmisc
    unzip
    zip
    neovim
    git
    lazygit
    btop
    fastfetch
    wget
    wl-clipboard
    grim
    slurp
    brightnessctl
    waybar
    wofi
    swww
    texlive.combined.scheme-medium
    zathura
    fzf
    bat
    ripgrep
 ];

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}

