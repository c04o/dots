{
  config,
  pkgs,
  theme,
  ...
}: {
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
}
