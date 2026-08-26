{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      # UI & QoL basic setups
      binds.whichKey.enable = true;
      autopairs.nvim-autopairs.enable = true;
      statusline.lualine.enable = true;
      autocomplete.nvim-cmp.enable = true;
      git.gitsigns.enable = true;

      # Core options
      options = {
        termguicolors = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        number = true;
        relativenumber = true;
        cursorline = true;
      };

      # Dynamic theme matching
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };

      # Global variable space
      globals = {
        mapleader = " ";
      };
    };
  };
}
