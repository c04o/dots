{pkgs, ...}: let
  theme = import ../theme/default.nix;
in {
  config.flake.modules = {
    # system-wide layer
    nixos.c04o = {
      programs = {
        # Smart and user-friendly command line shell
        fish.enable = true;

        # Fast cd command that learns your habits
        zoxide = {
          enable = true;
          enableFishIntegration = true;
        };
      };
      users.users.coni.shell = pkgs.fish;
    };

    # user layer (home manager)
    homeManager.coni = {
      # Minimal, blazing fast, and extremely customizable prompt for any shell
      programs.starship = {
        enable = true;
        enableFishIntegration = true;

        settings = {
          "$schema" = "https://starship.rs/config-schema.json";

          format =
            "[](blue)$os$username"
            + "[](bg:aqua fg:blue)$directory"
            + "[](bg:green fg:aqua)$git_branch$git_status"
            + "[](bg:yellow fg:green)$c$rust$golang$nodejs$php$java$kotlin$haskell$python"
            + "[](bg:bg3 fg:yellow)$conda$docker_context"
            + "[](bg:bg2 fg:bg3)$time"
            + "[ ](fg:bg2)$cmd_duration$line_break$character";

          palette = "${theme.theme.name}";

          os = {
            disabled = false;
            style = "bg:blue fg:bg0";
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
            style_user = "bg:blue fg:bg0";
            style_root = "bg:blue fg:bg0";
            format = "[ $user]($style)";
          };

          directory = {
            style = "bg:aqua fg:bg0";
            format = "[ $path ]($style)";
            truncation_length = 3;
            truncation_symbol = "…/";
            substitutions = {
              "Documents" = "󰈙 ";
              Downloads = " ";
              Music = "󰝚 ";
              "Pictures" = " ";
              Developer = "󰲋 ";
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
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          c = {
            symbol = " ";
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          rust = {
            symbol = "";
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          golang = {
            symbol = "";
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          php = {
            symbol = "";
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          java = {
            symbol = " ";
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          kotlin = {
            symbol = "";
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          haskell = {
            symbol = "";
            style = "bg:yellow";
            format = "[[ $symbol( $version) ](fg:bg0 bg:yellow)]($style)";
          };
          python = {
            symbol = "";
            style = "bg:yellow";
            format = "[[ $symbol( $version)(\\(#$virtualenv\\)) ](fg:bg0 bg:yellow)]($style)";
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
            style = "bg:bg2";
            format = "[[  $time ](fg:fg0 bg:bg2)]($style)";
          };

          line_break.disabled = false;

          character = {
            disabled = false;
            success_symbol = "[❯](bold fg:blue)";
            error_symbol = "[❯](bold fg:red)";
            vimcmd_symbol = "[❮](bold fg:blue)";
            vimcmd_replace_one_symbol = "[❮](bold fg:purple)";
            vimcmd_replace_symbol = "[❮](bold fg:purple)";
            vimcmd_visual_symbol = "[❮](bold fg:orange)";
          };

          cmd_duration = {
            show_milliseconds = true;
            format = " in $duration ";
            style = "fg:fg0";
            disabled = false;
            show_notifications = true;
            min_time_to_notify = 45000;
          };

          # Automatically map your system theme colors onto Starship blocks
          palettes.${theme.theme.name} = {
            bg0 = theme.colors.bg0;
            bg2 = theme.colors.bg2;
            bg3 = theme.colors.bg3;
            fg0 = theme.colors.fg;
            red = theme.colors.red;
            green = theme.colors.green;
            yellow = theme.colors.yellow;
            blue = theme.colors.blue;
            purple = theme.colors.purple;
            aqua = theme.colors.aqua;
            orange = theme.colors.orange;
          };
        };
      };

      # Command-line fuzzy finder written in Go
      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
      };

      # Interactive shell options, scripts, and aliases brought over from configs/fish.nix
      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          # disable welcome greeting
          set -g fish_greeting

          # custom fzf script
          function f
            fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' \
                --bind 'enter:become(nvim {})' \
                --bind 'alt-c:execute-silent(cat {} | wl-copy)+abort' \
                --bind 'alt-p:execute-silent(echo -n {} | wl-copy)+abort' \
                --header (echo -e 'Enter \033[33m\033[0m • Alt-C \033[33m󰆏\033[0m • Alt+P \033[33m\033[0m') \
                --layout=reverse --border
          end
        '';

        shellAliases = {
          # system & tools
          c = "clear";
          v = "nvim";
          b = "bat";
          cat = "bat";
          ff = "fastfetch";
          y = "yazi";
          bt = "btop";

          # safe core utilities
          r = "rm -I";
          rf = "rm -rf";
          cp = "cp -iv";
          mv = "mv -iv";
          mkdir = "mkdir -p"; # always make parent dirs

          # clipboard
          yc = "wl-copy <";
          yp = "wl-paste"; # companion to paste terminal output

          # modern search
          grep = "rg";
          find = "fd";

          # nix
          rb = "sudo nixos-rebuild switch --flake .";
          # test config without adding boot entry
          rt = "sudo nixos-rebuild test --flake .";
          ng = "nix-collect-garbage -d";
          nfu = "nix flake update";
          ns = "nix search nixpkgs";
          aj = "alejandra .";

          # dir nav
          ".." = "cd ..";
          "..." = "cd ../..";
          ls = "eza --icons --group-directories-first";
          e = "eza -lh --icons --git --group-directories-first --tree --level=2";
          ee = "eza -lah --icons --git --group-directories-first";

          # git
          g = "git";
          lg = "lazygit";
          ga = "git add";
          gc = "git commit";
          gp = "git push";
          gpf = "git push --force-with-lease";
          gco = "git checkout";
          gl = "git log --graph --oneline --all --decorate";
          gr = "git restore";
        };
      };

      # System monitor
      programs.btop = {
        enable = true;

        settings = {
          update_ms = 100;
          color_theme = theme.theme.name;
          theme_background = false;
          true_background = false;
          vim_keys = true;
          rounded_corners = true;
          shown_boxes = "cpu mem net proc";
        };
      };

      xdg.configFile."btop/themes/${theme.theme.name}.theme".text = ''
        theme[main_fg]="${theme.colors.fg}"
        theme[title]="${theme.colors.green}"
        theme[hi_fg]="${theme.colors.yellow}"
        theme[selected_bg]="${theme.colors.bg2}"
        theme[selected_fg]="${theme.colors.fg}"
        theme[inactive_fg]="${theme.colors.bg5}"
        theme[graph_text]="${theme.colors.bg5}"
        theme[div_line]="${theme.colors.bg2}"

        theme[cpu_box]="${theme.colors.bg5}"
        theme[mem_box]="${theme.colors.bg5}"
        theme[net_box]="${theme.colors.bg5}"
        theme[proc_box]="${theme.colors.bg5}"

        theme[cpu_start]="${theme.colors.green}"
        theme[cpu_mid]="${theme.colors.yellow}"
        theme[cpu_end]="${theme.colors.red}"

        theme[temp_start]="${theme.colors.green}"
        theme[temp_mid]="${theme.colors.yellow}"
        theme[temp_end]="${theme.colors.red}"

        theme[free_start]="${theme.colors.green}"
        theme[free_mid]="${theme.colors.green}"
        theme[free_end]="${theme.colors.green}"

        theme[cached_start]="${theme.colors.blue}"
        theme[cached_mid]="${theme.colors.blue}"
        theme[cached_end]="${theme.colors.blue}"

        theme[available_start]="${theme.colors.aqua}"
        theme[available_mid]="${theme.colors.aqua}"
        theme[available_end]="${theme.colors.aqua}"

        theme[used_start]="${theme.colors.red}"
        theme[used_mid]="${theme.colors.red}"
        theme[used_end]="${theme.colors.red}"

        theme[download_start]="${theme.colors.aqua}"
        theme[download_mid]="${theme.colors.blue}"
        theme[download_end]="${theme.colors.purple}"

        theme[upload_start]="${theme.colors.yellow}"
        theme[upload_mid]="${theme.colors.red}"
        theme[upload_end]="${theme.colors.red}"

        theme[process_start]="${theme.colors.green}"
        theme[process_mid]="${theme.colors.yellow}"
        theme[process_end]="${theme.colors.red}"
      '';
    };
  };
}
