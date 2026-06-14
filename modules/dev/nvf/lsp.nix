{...}: {
  programs.nvf.settings.vim = {
    # LSP & Treesitter context engine
    lsp = {
      enable = true;
      formatOnSave = true;
      trouble.enable = true;
      lspSignature.enable = true;
      presets.tailwindcss-language-server.enable = true;
    };

    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      autotagHtml = true;
      context.enable = true;
    };

    # Language support grid
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
      typescript = {
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
  };
}
