{
  pkgs,
  theme,
  ...
}: let
  # downloads the url & turn it into a local image
  wallpaperImg = pkgs.fetchurl {
    url = theme.wallpaper.url;
    hash = theme.wallpaper.sha256;
  };
in {
  
    home.packages = [pkgs.wbg];

    # append wbg directly to niri startup using the downloaded image
    programs.niri.settings.spawn-at-startup = [
      {command = ["${pkgs.wbg}/bin/wbg" "${wallpaperImg}"];}
    ];
}
