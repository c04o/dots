{pkgs, ...}: {
  programs.nvf.settings.vim = {
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

    # External plugin registration
    extraPlugins = with pkgs.vimPlugins; {
      snacks = {
        package = snacks-nvim;
      };
    };

    # Dynamic snacks config generation
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
}
