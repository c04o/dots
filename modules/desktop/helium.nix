{inputs, ...}: {
  # import home manager module from flake
  imports = [
    inputs.helium-flake.homeModules.default
  ];

  programs.helium = {
    enable = true;

    # cli arguments passed to helium
    flags = [
      # recommended for wayland
      "--ozone-platform-hint=auto"
    ];

    policies = {
      # won't let log in with google to sync history, etc
      "BrowserSignin" = 0;
    };
  };
}
