{
  config,
  pkgs,
  ...
}: let
  # init toml gen
  tomlFormat = pkgs.formats.toml {};
in {
  # install the sunsetr pkg
  home.packages = [pkgs.sunsetr];

  # generate the config file at ~/.config/sunsetr/sunsetr.toml
  xdg.configFile."sunsetr/sunsetr.toml".source = tomlFormat.generate "sunsetr-config" {
    # bypass hyprsunset backend
    backend = "wayland";
    transition_mode = "finish_by";

    # smoothing
    smoothing = true;
    startup_duration = 0.5;
    shutdown_duration = 0.5;
    adaptive_interval = 1;

    # time-based config
    night_temp = 3000;
    day_temp = 6500;
    night_gamma = 100;
    day_gamma = 100;
    update_interval = 60;

    # transitions
    sunset = "18:00:00";
    sunrise = "05:00:00";
    transition_duration = 45;
  };
}
