{
  pkgs,
  config,
  inputs,
  theme,
  ...
}: {
  
    programs.walker = {
      enable = true;
      config = {
        theme = "${theme.theme.name}";
        close_when_open = true;
        disable_mouse = true;
        hide_action_hints = false;
        placeholders."default" = {
          input = "Start typing…";
          list = "No results";
        };
        providers = {
          default = ["desktopapplications" "calc" "websearch"];
          prefixes = [
            {
              prefix = "/";
              provider = "files";
            }
            {
              prefix = ":";
              provider = "clipboard";
            }
            {
              prefix = "=";
              provider = "calc";
            }
            {
              prefix = "@";
              provider = "websearch";
            }
            {
              prefix = "!";
              provider = "todo";
            }
            {
              prefix = "*";
              provider = "bitwarden";
            }
            {
              prefix = ">";
              provider = "runner";
            }
            {
              prefix = "+";
              provider = "wireplumber";
            }
            {
              prefix = "~";
              provider = "niriactions";
            }
            {
              prefix = "b";
              provider = "bluetooth";
            }
          ];
          clipboard.time_format = "relative";
          actions.bitwarden = [
            {
              action = "copypassword";
              label = "copy password";
              default = true;
              bind = "Return";
            }
            {
              action = "typepassword";
              label = "type password";
              default = true;
              bind = "ctrl p";
            }
            {
              action = "copyusername";
              label = "copy username";
              bind = "shift Return";
            }
            {
              action = "typeusername";
              label = "type username";
              bind = "ctrl u";
            }
            {
              action = "copyotp";
              label = "copy 2fa";
              bind = "ctrl Return";
            }
            {
              action = "typeotp";
              label = "type 2fa";
              bind = "ctrl t";
            }
            {
              action = "syncvault";
              label = "sync";
              bind = "ctrl s";
            }
          ];
        };
        keybinds = {
          close = ["Escape"];
          next = ["Down"];
          previous = ["Up"];
        };
      };

      themes."${theme.theme.name}" = {
        style = ''
          * { font-family: "${theme.fonts.sans}", "${theme.fonts.mono}"; color: ${theme.colors.fg}; }
          window { background: transparent; }
          #box { background-color: ${theme.colors.bg0}; border: 2px solid ${theme.colors.bg2}; border-radius: 12px; padding: 12px; }
          #search { background-color: ${theme.colors.bg1}; border-radius: 8px; padding: 10px 14px; font-size: 1.2rem; border: 2px solid ${theme.colors.bg_dim}; margin-bottom: 12px; box-shadow: none; }
          #search:focus { border: 2px solid ${theme.colors.green}; }
          #list { margin-top: 4px; }
          .item { padding: 8px 12px; border-radius: 8px; }
          .item:selected { background-color: ${theme.colors.bg2}; }
          .title { font-weight: bold; font-size: 1.1rem; }
          .sub { color: ${theme.colors.grey1}; font-size: 0.9rem; }
        '';
      };
    };
}
