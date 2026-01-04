{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "c04o";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Managua";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

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
    extraGroups = ["networkmanager" "wheel"];
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
      l = "ls -lA";

      # Git basics
      g = "git";
      lg = "lazygit";
      ga = "git add";
      gaa = "git add --all";
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

      format = "[](orange)$os$username[](bg:yellow fg:orange)$directory[](bg:green fg:yellow)$git_branch$git_status[](fg:green bg:aqua)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:aqua bg:bg3)$conda$docker_context[](fg:bg3 bg:bg1)$time[ ](fg:bg1)$cmd_duration$line_break$character";

      palettes.gruvbox_material_dark_soft = {
        bg0 = "#32302f";
        bg1 = "#3c3836";
        bg3 = "#504945";
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
        style = "bg:orange fg:bg0";
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
        style_user = "bg:orange fg:bg0";
        style_root = "bg:orange fg:bg0";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:yellow fg:bg0";
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
        style = "bg:green";
        format = "[[ $symbol $branch ](fg:bg0 bg:green)]($style)";
      };

      git_status = {
        style = "bg:green";
        format = "[[($all_status$ahead_behind )](fg:bg0 bg:green)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $version) ](fg:bg0 bg:aqua)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:aqua";
        format = "[[ $symbol( $version)(\(#$virtualenv\)) ](fg:bg0 bg:aqua)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:bg3";
        format = "[[ $symbol( $context) ](fg:fg0 bg:bg3)]($style)";
      };

      conda = {
        symbol = "  ";
        style = "bg:bg3";
        format = "[[ $symbol$environment ](fg:fg0 bg:bg3)]($style)";
        ignore_base = false;
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:bg1";
        format = "[[  $time ](fg:fg0 bg:bg1)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:aqua)";
        error_symbol = "[❯](bold fg:orange)";
        vimcmd_symbol = "[❮](bold fg:aqua)";
        vimcmd_replace_one_symbol = "[❮](bold fg:bg1)";
        vimcmd_replace_symbol = "[❮](bold fg:bg1)";
        vimcmd_visual_symbol = "[❮](bold fg:green)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = " in $duration ";
        style = "bg:bg1 fg:fg0";
        disabled = false;
        show_notifications = true;
        min_time_to_notify = 45000;
      };
    };
  };

  programs.firefox.enable = true;

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    package = pkgs.steam.override {
      extraEnv = {
        STEAM_FORCE_DESKTOPUI_SCALING = "1";
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    sunsetr
    alacritty
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
    typst
    tinymist
    typstyle
    zathura
    fzf
    eza
    bat
    ripgrep
    protonup-qt
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    annotation-mono
    inter
  ];

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  systemd.user.services.xwayland-satellite = {
    description = "Xwayland Satellite";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    serviceConfig = {
      # This removes WAYLAND_DISPLAY before starting the satellite
      ExecStart = "${pkgs.coreutils}/bin/env -u WAYLAND_DISPLAY ${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "always";
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}
