{pkgs, ...}: let
  theme = import ../theme/default.nix;
  myWallpaper = pkgs.fetchurl {
    url = theme.wallpaper.url;
    sha256 = theme.wallpaper.sha256;
  };
in {
  config.flake.modules.homeManager.coni = {
    home.packages = [pkgs.wbg];

    # append wbg directly to niri startup
    programs.niri.settings.spawn-at-startup = [
      {command = ["${pkgs.wbg}/bin/wbg" "${myWallpaper}"];}
    ];
  };
}
