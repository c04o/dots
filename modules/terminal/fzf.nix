{...}: {
  home-manager.users.coni = {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
