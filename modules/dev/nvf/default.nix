{
  config,
  inputs,
  theme,
  ...
}: {
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
        name = theme.theme.name;
        style = theme.theme.style;
      };

      # Global variable space
      globals = {
        mapleader = " ";
        everforest_background = theme.theme.style; # hard, medium, soft
        everforest_transparent_background = 0; # 0: opaque, 1: transparent
        everforest_better_performance = 1;
        everforest_enable_italic = 1; # 0: disabled, 1: enabled
        everforest_diagnostic_text_highlight = 1;
      };
    };
  };
}
