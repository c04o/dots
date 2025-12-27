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
	echo -e "\033[32m Yanked to clipboard!\033[0m"
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

      # Nix
      rb = "sudo nixos-rebuild switch --flake .";
      ngc = "nix-collect-garbage -d";

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
      glr = "git pull --rebase";
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

  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      
      palette = "gruvbox_material_dark_soft";

      format = "[](red)$os$username[](bg:orange fg:red)$directory[](bg:yellow fg:orange)$git_branch$git_status[](fg:yellow bg:green)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:green bg:aqua)$conda$docker_context[](fg:aqua bg:purple)$time[ ](fg:purple)$cmd_duration$line_break$character";

      palettes.gruvbox_material_dark_soft = {
        bg_dim = "#252423";
        bg0 = "#32302F";
        bg1 = "#3c3836";
        fg0 = "#d4be98";
        red = "#ea6962";
        green = "#a9b665";
        yellow = "#d8a657";
        blue = "#7daea3";
        purple = "#d3869b";
        aqua = "#89b482";
        orange = "#e78a4e";
      };

      os = {
        disabled = false;
        style = "bg:red fg:bg0";
        symbols = {
          Windows = "";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          AOSC = "";
          Arch = "󰣇";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          NixOS = "";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:red fg:bg0";
        style_root = "bg:red fg:bg0";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:orange fg:bg0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol $branch ](fg:bg0 bg:yellow)]($style)";
      };

      git_status = {
        style = "bg:yellow";
        format = "[[($all_status$ahead_behind )](fg:bg0 bg:yellow)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:bg0 bg:green)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version)(\(#$virtualenv\)) ](fg:bg0 bg:green)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $context) ](fg:bg0 bg:aqua)]($style)";
      };

      conda = {
        symbol = "  ";
        style = "bg:aqua";
        format = "[[ $symbol$environment ](fg:bg0 bg:aqua)]($style)";
        ignore_base = false;
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:purple";
        format = "[[  $time ](fg:bg0 bg:purple)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:purple)";
        vimcmd_replace_symbol = "[❮](bold fg:purple)";
        vimcmd_visual_symbol = "[❮](bold fg:yellow)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = " in $duration ";
        style = "bg:purple";
        disabled = false;
        show_notifications = true;
        min_time_to_notify = 45000;
      };
    };
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

