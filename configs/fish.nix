{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # disable welcome greeting
      set -g fish_greeting

      # custom fzf script
      function f
        fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' \
            --bind 'enter:become(nvim {})' \
            --bind 'alt-c:execute-silent(cat {} | wl-copy)+abort' \
            --bind 'alt-p:execute-silent(echo -n {} | wl-copy)+abort' \
            --header (echo -e 'Enter \033[33m\033[0m • Alt-C \033[33m󰆏\033[0m • Alt+P \033[33m\033[0m') \
            --layout=reverse --border
      end
    '';

    shellAliases = {
      # system & tools
      c = "clear";
      v = "nvim";
      b = "bat";
      cat = "bat";
      ff = "fastfetch";
      y = "yazi";
      bt = "btop";

      # safe core utilities
      r = "rm -I";
      rf = "rm -rf";
      cp = "cp -iv";
      mv = "mv -iv";
      # always make parent dirs
      mkdir = "mkdir -p";

      # clipboard
      yc = "wl-copy <";
      # companion to paste terminal output
      yp = "wl-paste";

      # modern search
      grep = "rg";
      find = "fd";

      # nix
      rb = "sudo nixos-rebuild switch --flake .";
      # test config without adding bootloader entry
      rt = "sudo nixos-rebuild test --flake .";
      ng = "nix-collect-garbage -d";
      nfu = "nix flake update";
      ns = "nix search nixpkgs";
      aj = "alejandra .";

      # dir nav
      ".." = "cd ..";
      "..." = "cd ../..";
      ls = "eza --icons --group-directories-first";
      e = "eza -lh --icons --git --group-directories-first --tree --level=2";
      ee = "eza -lah --icons --git --group-directories-first";

      # git
      g = "git";
      lg = "lazygit";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gco = "git checkout";
      gl = "git log --graph --oneline --all --decorate";
      gr = "git restore";
    };
  };
}
