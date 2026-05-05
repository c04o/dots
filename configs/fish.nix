{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    # Custom fzf function translated to Fish
    interactiveShellInit = ''
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
      gc = "git commit";
      gp = "git push";
    };
  };
}
