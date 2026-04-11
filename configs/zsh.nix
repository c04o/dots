{pkgs, ...}: {
  # enable fzf and let home-manager handle the zsh integration automatically
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # custom fzf script for quick copying/neovim-ing
    initContent = ''
      unalias f 2>/dev/null
      f() {
        fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' \
            --bind 'enter:become(nvim {})' \
            --bind 'alt-c:execute-silent(cat {} | wl-copy)+abort' \
            --bind 'alt-p:execute-silent(echo -n {} | wl-copy)+abort' \
            --header $'Enter \033[33m\033[0m • Alt-C \033[33m󰆏\033[0m • Alt+P \033[33m\033[0m' \
            --layout=reverse --border
      }
    '';

    shellAliases = {
      # system & tools
      c = "clear";
      v = "nvim";
      b = "bat";
      ff = "fastfetch";
      r = "rm -I";
      rf = "rm -rf";
      y = "yazi";
      bt = "btop";
      yc = "wl-copy <";

      # nix
      rb = "sudo nixos-rebuild switch --flake .";
      ng = "nix-collect-garbage -d";
      aj = "alejandra .";

      # dir nav
      ".." = "cd ..";
      "..." = "cd ../..";
      e = "eza -lh --icons --git --group-directories-first --tree --level=2";
      ee = "eza -lah --icons --git --group-directories-first";

      # git basics
      g = "git";
      lg = "lazygit";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gp = "git push";
      gpo = "git push -u origin HEAD";
      gl = "git pull";
      glr = "git pull --rebase";
      gs = "git status";
      gds = "git diff --staged";

      # git branching
      gb = "git branch";
      gba = "git branch -a";
      gco = "git checkout";
      gd = "git diff";
      gst = "git stash";
      gstp = "git stash pop";
      gstl = "git stash list";
      glo = "git log --oneline --graph --decorate";
    };
  };
}
