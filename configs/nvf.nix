{ pkgs, theme, ... }: {
  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        # ui & qol
        binds.whichKey.enable = true;
        autopairs.nvim-autopairs.enable = true;
        statusline.lualine.enable = true;
        autocomplete.nvim-cmp.enable = true;
        git.gitsigns.enable = true;

        options = {
          termguicolors = true;
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          number = true;
          relativenumber = true;
          cursorline = true;
        };

        # theme
        theme = {
          enable = true;
          name = theme.theme.name;
          style = theme.theme.style;
        };

        globals = {
          mapleader = " "; # from keymaps
          everforest_background = theme.theme.style; # hard, medium, soft
          everforest_transparent_background = 0; # 0: opaque, 1: transparent
          everforest_better_performance = 1;
          everforest_enable_italic = 1; # 0: disabled, 1: enabled
          everforest_diagnostic_text_highlight = 1;
        };

        # lsp & treesitter
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

        # language-specific
        languages = {
          rust = { enable = true; crates.enable = true; lsp.enable = true; treesitter.enable = true; format.enable = true; };
          go = { enable = true; lsp.enable = true; treesitter.enable = true; format.enable = true; };
          clang = { enable = true; lsp.enable = true; treesitter.enable = true; };
          zig = { enable = true; lsp.enable = true; treesitter.enable = true; };
          lua = { enable = true; lsp.enable = true; treesitter.enable = true; format.enable = true; };
          markdown = { enable = true; format.enable = true; lsp.enable = true; treesitter.enable = true; };
          typst = { enable = true; format.enable = true; lsp.enable = true; treesitter.enable = true; };
          json = { enable = true; treesitter.enable = true; lsp.enable = true; };
          yaml = { enable = true; lsp.enable = true; treesitter.enable = true; };
          toml.enable = true;
          xml.enable = true;
          ts = { enable = true; format.enable = true; lsp.enable = true; treesitter.enable = true; };
          svelte = { enable = true; lsp.enable = true; treesitter.enable = true; };
          html = { enable = true; treesitter.enable = true; };
          css = { enable = true; lsp.enable = true; treesitter.enable = true; };
          tailwind.enable = true;
          python = { enable = true; lsp.enable = true; treesitter.enable = true; format.enable = true; };
          nix = { enable = true; format.enable = true; lsp.enable = true; treesitter.enable = true; };
          bash = { enable = true; format.enable = true; lsp.enable = true; treesitter.enable = true; };
          sql.enable = true;
        };

        # keymaps
        keymaps = [
          # picker
          { key = "<leader>ff"; mode = "n"; silent = true; action = "<cmd>lua Snacks.picker.files()<CR>"; desc = "Find Files"; }
          { key = "<leader>fg"; mode = "n"; silent = true; action = "<cmd>lua Snacks.picker.grep()<CR>"; desc = "Find Text"; }
          { key = "<leader>fb"; mode = "n"; silent = true; action = "<cmd>lua Snacks.picker.buffers()<CR>"; desc = "Find Buffers"; }
 
          # explorer
          { key = "<leader>e"; mode = "n"; silent = true; action = "<cmd>lua Snacks.explorer()<CR>"; desc = "Toggle Explorer"; }
         
          # trouble (err list)
          { key = "<leader>xx"; mode = "n"; silent = true; action = "<cmd>Trouble diagnostics toggle<CR>"; desc = "Toggle Error List"; }
         
           # gen
          { key = "<leader>w"; mode = "n"; silent = true; action = "<cmd>w<CR>"; desc = "Save"; }
          { key = "<leader>q"; mode = "n"; silent = true; action = "<cmd>q<CR>"; desc = "Quit"; }
         
          # snacks git / utility
          { key = "<leader>gg"; mode = "n"; silent = true; action = "<cmd>lua Snacks.lazygit()<CR>"; desc = "Open Lazygit"; }
          { key = "<leader>gb"; mode = "n"; silent = true; action = "<cmd>lua Snacks.gitbrowse()<CR>"; desc = "Open in Browser"; }
         
          # snacks buffers & terminal
          { key = "<leader>bd"; mode = "n"; silent = true; action = "<cmd>lua Snacks.bufdelete()<CR>"; desc = "Delete Buffer"; }
          { key = "<leader>tt"; mode = "n"; silent = true; action = "<cmd>lua Snacks.terminal()<CR>"; desc = "Toggle Terminal"; }
          { key = "<leader>z"; mode = "n"; silent = true; action = "<cmd>lua Snacks.zen()<CR>"; desc = "Toggle Zen Mode"; }
          { key = "<leader>s"; mode = "n"; silent = true; action = "<cmd>lua Snacks.scratch()<CR>"; desc = "Toggle Scratch Buffer"; }
          { key = "<leader>nh"; mode = "n"; silent = true; action = "<cmd>lua Snacks.notifier.show_history()<CR>"; desc = "Notification History"; }
          { key = "<leader>rn"; mode = "n"; silent = true; action = "<cmd>lua Snacks.rename.rename_file()<CR>"; desc = "Rename File"; }
          { key = "]]"; mode = ["n" "t"]; silent = true; action = "<cmd>lua Snacks.words.jump(1, true)<CR>"; desc = "Next LSP Reference"; }
          { key = "[["; mode = ["n" "t"]; silent = true; action = "<cmd>lua Snacks.words.jump(-1, true)<CR>"; desc = "Prev LSP Reference"; }
        ];

        # snacks plugins (from default.nix)
        extraPlugins = with pkgs.vimPlugins; {
          snacks = {
            package = snacks-nvim;
          };
        };

        luaConfigRC.snacks-setup = ''
          local snacks_config = vim.fn.json_decode('${builtins.toJSON {
            # Efficient animations inclduing over 45 easing functions
            animate = {enabled = true;}; 
            
            # Deal with big files
            bigfile = {enabled = true;}; 
            
            # Delete buffers without disrupting window layout
            bufdelete = {enabled = true;}; 
            
            # Beautiful declarative dashboards
            dashboard = {enabled = true;}; 
            
            # Focus on the active scope by dimming the rest
            dim = {enabled = true;}; 
            
            # A file explorer
            explorer = {enabled = true;}; 
            
            # Open the current file, branch, commit, or repo in a browser
            gitbrowse = {enabled = true;}; 
            
            # Image viewer
            image = {enabled = true;}; 
            
            # Indent guides and scopes
            indent = {enabled = true;}; 
            
            # Better `vim.ui.input`
            input = {enabled = true;}; 
            
            # Open LazyGit in a float
            lazygit = {enabled = true;}; 
            
            # Pretty `vim.notify`
            notifier = {enabled = true;}; 
            
            # Picker for selecting items
            picker = {enabled = true;}; 
            
            # Faster file rendering
            quickfile = {enabled = true;}; 
            
            # LSP-integrated file renaming
            rename = {enabled = true;}; 
            
            # Scope detection
            scope = {enabled = true;}; 
            
            # Scratch buffers with a persistent file
            scratch = {enabled = true;}; 
            
            # Smooth scrolling
            scroll = {enabled = true;}; 
            
            # Status column
            statuscolumn = {enabled = true;};
            
            # Create and toggle terminals
            terminal = {enabled = true;}; 
            
            # Toggle keymaps integrated with which-key Icons / colors
            toggle = {enabled = true;}; 
            
            # Auto-show LSP references and navigate them
            words = {enabled = true;}; 
            
            # Zen mode • distraction-free coding
            zen = {enabled = true;}; 
          }}')

          require('snacks').setup(snacks_config)
        '';
      };
    };
  };
}
