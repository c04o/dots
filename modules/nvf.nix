{
  pkgs,
  config,
  ...
}: let
  theme = import ../theme/default.nix;
in {
  config.flake.modules = {
    # user layer (home manager)
    homeManager.coni = {
      programs.nvf = {
        enable = true;
        enableManpages = true;

        settings = {
          vim = {
            viAlias = true;
            vimAlias = true;

            # ui & qol plugins
            binds.whichKey.enable = true;
            autopairs.nvim-autopairs.enable = true;
            statusline.lualine.enable = true;
            autocomplete.nvim-cmp.enable = true;
            git.gitsigns.enable = true;

            # core options
            options = {
              termguicolors = true;
              tabstop = 2;
              shiftwidth = 2;
              expandtab = true;
              number = true;
              relativenumber = true;
              cursorline = true;
            };

            # dynamic theme matching
            theme = {
              enable = true;
              name = theme.theme.name;
              style = theme.theme.style;
            };

            # global variable space
            globals = {
              mapleader = " ";
              everforest_background = theme.theme.style; # hard, medium, soft
              everforest_transparent_background = 0; # 0: opaque, 1: transparent
              everforest_better_performance = 1;
              everforest_enable_italic = 1; # 0: disabled, 1: enabled
              everforest_diagnostic_text_highlight = 1;
            };

            # lsp & treesitter context engine
            lsp = {
              enable = true;
              formatOnSave = true;
              trouble.enable = true;
              lspSignature.enable = true;
            };
            treesitter = {
              enable = true;
              highlight.enable = true;
              indent.enable = true;
              autotagHtml = true;
              context.enable = true;
            };

            # language support grid
            languages = {
              rust = {
                enable = true;
                extensions.crates-nvim.enable = true;
                lsp.enable = true;
                treesitter.enable = true;
                format.enable = true;
              };
              go = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
                format.enable = true;
              };
              clang = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              zig = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              lua = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
                format.enable = true;
              };
              markdown = {
                enable = true;
                format.enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              typst = {
                enable = true;
                format.enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              json = {
                enable = true;
                treesitter.enable = true;
                lsp.enable = true;
              };
              yaml = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              toml.enable = true;
              xml.enable = true;
              ts = {
                enable = true;
                format.enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              svelte = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              html = {
                enable = true;
                treesitter.enable = true;
              };
              css = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              tailwind.enable = true;
              python = {
                enable = true;
                lsp.enable = true;
                treesitter.enable = true;
                format.enable = true;
              };
              nix = {
                enable = true;
                format.enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              bash = {
                enable = true;
                format.enable = true;
                lsp.enable = true;
                treesitter.enable = true;
              };
              sql.enable = true;
            };

            # Keybindings System Integrated with Snacks Core Features
            keymaps = [
              {
                key = "<leader>ff";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.picker.files()<CR>";
                desc = "Find Files";
              }
              {
                key = "<leader>fg";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.picker.grep()<CR>";
                desc = "Find Text";
              }
              {
                key = "<leader>fb";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.picker.buffers()<CR>";
                desc = "Find Buffers";
              }
              {
                key = "<leader>e";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.explorer()<CR>";
                desc = "Toggle Explorer";
              }
              {
                key = "<leader>xx";
                mode = "n";
                silent = true;
                action = "<cmd>Trouble diagnostics toggle<CR>";
                desc = "Toggle Error List";
              }
              {
                key = "<leader>w";
                mode = "n";
                silent = true;
                action = "<cmd>w<CR>";
                desc = "Save";
              }
              {
                key = "<leader>q";
                mode = "n";
                silent = true;
                action = "<cmd>q<CR>";
                desc = "Quit";
              }
              {
                key = "<leader>gg";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.lazygit()<CR>";
                desc = "Open Lazygit";
              }
              {
                key = "<leader>gb";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.gitbrowse()<CR>";
                desc = "Open in Browser";
              }
              {
                key = "<leader>bd";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.bufdelete()<CR>";
                desc = "Delete Buffer";
              }
              {
                key = "<leader>tt";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.terminal()<CR>";
                desc = "Toggle Terminal";
              }
              {
                key = "<leader>z";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.zen()<CR>";
                desc = "Toggle Zen Mode";
              }
              {
                key = "<leader>s";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.scratch()<CR>";
                desc = "Toggle Scratch Buffer";
              }
              {
                key = "<leader>nh";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.notifier.show_history()<CR>";
                desc = "Notification History";
              }
              {
                key = "<leader>rn";
                mode = "n";
                silent = true;
                action = "<cmd>lua Snacks.rename.rename_file()<CR>";
                desc = "Rename File";
              }
              {
                key = "]]";
                mode = ["n" "t"];
                silent = true;
                action = "<cmd>lua Snacks.words.jump(1, true)<CR>";
                desc = "Next LSP Reference";
              }
              {
                key = "[[";
                mode = ["n" "t"];
                silent = true;
                action = "<cmd>lua Snacks.words.jump(-1, true)<CR>";
                desc = "Prev LSP Reference";
              }
            ];

            # external plugin registration
            extraPlugins = with pkgs.vimPlugins; {
              snacks = {
                package = snacks-nvim;
              };
            };

            # dynamic snacks config generation
            luaConfigRC.snacks-setup = ''
              local snacks_config = vim.fn.json_decode('${builtins.toJSON {
                animate = {enabled = true;};
                bigfile = {enabled = true;};
                bufdelete = {enabled = true;};
                dashboard = {enabled = true;};
                dim = {enabled = true;};
                explorer = {enabled = true;};
                gitbrowse = {enabled = true;};
                image = {enabled = true;};
                indent = {enabled = true;};
                input = {enabled = true;};
                lazygit = {enabled = true;};
                notifier = {enabled = true;};
                picker = {enabled = true;};
                quickfile = {enabled = true;};
                rename = {enabled = true;};
                scope = {enabled = true;};
                scratch = {enabled = true;};
                scroll = {enabled = true;};
                statuscolumn = {enabled = true;};
                terminal = {enabled = true;};
                toggle = {enabled = true;};
                words = {enabled = true;};
                zen = {enabled = true;};
              }}')

              require('snacks').setup(snacks_config)
            '';
          };
        };
      };
    };
  };
}
