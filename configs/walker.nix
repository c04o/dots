{
  inputs,
  theme,
  ...
}: {
  # import home manager module from flake
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;

    # run walker as a background daemon for quick launches
    runAsService = true;

    config = {
      theme = "${theme.theme.name}";

      # general QoL tweaks
      close_when_open = true;
      disable_mouse = true;
      hide_action_hints = false;

      placeholders."default" = {
        input = "Start typing…";
        list = "No results";
      };

      providers = {
        # what shows up as soon as you open walker
        default = ["desktopapplications" "calc" "websearch"];

        # define favorite providers & their prefixes
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

        # explicit bitwarden actions
        actions = {
          bitwarden = [
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
      };

      # keymaps
      keybinds = {
        close = ["Escape"];
        next = ["Down"];
        previous = ["Up"];
      };
    };

    # custom theme
    themes."${theme.theme.name}" = {
      style = ''
        /* typography */
        * {
          font-family: "${theme.fonts.sans}", "${theme.fonts.mono}";
          color: ${theme.colors.fg};
        }

        /* make the root wayland window transparent (gtk4 conflict) */
        window {
          background: transparent;
        }

        /* main pop-up container */
        #box {
          background-color: ${theme.colors.bg0};
          border: 2px solid ${theme.colors.bg2};
          border-radius: 12px;
          padding: 12px;
        }

        /* search input field */
        #search {
          background-color: ${theme.colors.bg1};
          border-radius: 8px;
          padding: 10px 14px;
          font-size: 1.2rem;
          border: 2px solid ${theme.colors.bg_dim};
          margin-bottom: 12px;
          box-shadow: none;
        }

        /* highlight searchbar when typing */
        #search:focus {
          border: 2px solid ${theme.colors.green};
        }

        /* results list */
        #list {
          margin-top: 4px;
        }

        /* individual result items */
        .item {
          padding: 8px 12px;
          border-radius: 8px;
        }

        /* highlighted result */
        .item:selected {
          background-color: ${theme.colors.bg2};
        }

        /* app/command title */
        .title {
          font-weight: bold;
          font-size: 1.1rem;
        }

        /* subtitle/description */
        .sub {
          color: ${theme.colors.grey1};
          font-size: 0.9rem;
        }
      '';
    };
  };
}
