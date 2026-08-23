{
  pkgs,
  inputs,
  ...
}: {
  # expose dms-shell options to home-manager
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];
  programs.dank-material-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };
  };
}
