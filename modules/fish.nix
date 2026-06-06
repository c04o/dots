{pkgs, ...}: {
  config.flake.modules = {
    nixos.c04o = {
      programs = {
        # Smart and user-friendly command line shell
        fish.enable = true;
        # Fast cd command that learns your habits
        zoxide = {
          enable = true;
          enableFishIntegration = true;
        };
      };
      users.users.coni.shell = pkgs.fish;
    };

    homeManager.coni = {
      # Minimal, blazing fast, and extremely customizable prompt for any shell
      programs.starship = {
        enable = true;
      };
    };
  };
}
