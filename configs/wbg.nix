{
  pkgs,
  theme,
  ...
}: let
  # download the wallpaper image into the nix store at build time
  myWallpaper = pkgs.fetchurl {
    url = theme.wallpaper.url;
    sha256 = theme.wallpaper.sha256;
  };
in {
  home.packages = [pkgs.wbg];

  systemd.user.services.wbg = {
    Unit = {
      Description = "wbg Wayland wallpaper setter";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      # pass the image
      ExecStart = "${pkgs.wbg}/bin/wbg ${myWallpaper}";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
