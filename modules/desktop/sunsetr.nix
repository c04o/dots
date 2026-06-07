{pkgs, ...}: let
  tomlFormat = pkgs.formats.toml {};
in {
  config.flake.modules.homeManager.coni = {
    home.packages = [pkgs.sunsetr];

    xdg.configFile."sunsetr/sunsetr.toml".source = tomlFormat.generate "sunsetr-config" {
      backend = "wayland";
      transition_mode = "finish_by";
      smoothing = true;
      startup_duration = 0.5;
      shutdown_duration = 0.5;
      adaptive_interval = 1;
      night_temp = 3000;
      day_temp = 6500;
      night_gamma = 100;
      day_gamma = 100;
      update_interval = 60;
      sunset = "18:00:00";
      sunrise = "05:00:00";
      transition_duration = 45;
    };
  };
}
