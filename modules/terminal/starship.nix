{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format =
        "[](blue)$os$username"
        + "[](bg:teal fg:blue)$directory"
        + "[](bg:green fg:teal)$git_branch$git_status"
        + "[](bg:yellow fg:green)$c$rust$golang$nodejs$php$java$kotlin$haskell$python"
        + "[](bg:surface1 fg:yellow)$conda$docker_context"
        + "[](bg:surface0 fg:surface1)$time"
        + "[ ](fg:surface0)$cmd_duration$line_break$character";

      os = {
        disabled = false;
        style = "bg:blue fg:base";
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
        style_user = "bg:blue fg:base";
        style_root = "bg:blue fg:base";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:teal fg:base";
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
        format = "[[ $symbol $branch ](fg:base bg:green)]($style)";
      };
      git_status = {
        style = "bg:green";
        format = "[[($all_status$ahead_behind )](fg:base bg:green)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      c = {
        symbol = " ";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      php = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      java = {
        symbol = " ";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      kotlin = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      haskell = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol( $version) ](fg:base bg:yellow)]($style)";
      };
      python = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol( $version)(\\(#$virtualenv\\)) ](fg:base bg:yellow)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:surface1";
        format = "[[ $symbol( $context) ](fg:text bg:surface1)]($style)";
      };
      conda = {
        symbol = "  ";
        style = "bg:surface1";
        format = "[[ $symbol$environment ](fg:text bg:surface1)]($style)";
        ignore_base = false;
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:surface0";
        format = "[[  $time ](fg:text bg:surface0)]($style)";
      };

      line_break.disabled = false;

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:blue)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:blue)";
        vimcmd_replace_one_symbol = "[❮](bold fg:mauve)";
        vimcmd_replace_symbol = "[❮](bold fg:mauve)";
        vimcmd_visual_symbol = "[❮](bold fg:peach)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = " in $duration ";
        style = "fg:text";
        disabled = false;
        show_notifications = true;
        min_time_to_notify = 45000;
      };
    };
  };
}
