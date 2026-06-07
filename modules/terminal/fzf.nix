{...}: {
  config.flake.modules.homeManager.coni = {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
