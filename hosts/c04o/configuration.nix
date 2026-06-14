{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # bootloader & kernel
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "c04o";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Managua";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];
  };

  # required by home-manager for xdg portal linking when useUserPackages is enabled
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
    "/share/wayland-sessions"
  ];

  services = {
    displayManager = {
      ly.enable = true;
      sessionPackages = [
        pkgs.niri
      ];
    };
    dbus.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    desktopManager.gnome.enable = false;
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  security.rtkit.enable = true;

  users.users.coni = {
    isNormalUser = true;
    description = "coni";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
    # niri.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    gamemode.enable = true;
    # Digital distribution platform
    steam = {
      enable = true;

      # open firewall ports for local streaming/multiplayer
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      # fix for steam's ui on high-res
      package = pkgs.steam.override {
        extraEnv = {
          STEAM_FORCE_DESKTOPUI_SCALING = "1";
        };
      };
    };
  };

  # packages & env
  # allow propietary software (ew)
  nixpkgs.config.allowUnfree = true;

  # global packages
  environment.systemPackages = with pkgs; [
    # This program allows you read and control device brightness
    brightnessctl

    # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    psmisc

    # Command to produce a depth indented directory listing
    tree

    # Extraction utility for archives compressed in .zip format
    unzip

    # Tool for retrieving files using HTTP, HTTPS, and FTP
    wget

    # Compressor/archiver for creating and modifying zipfiles
    zip
  ];

  # auto-delete old nixos generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org/"
      "https://niri.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];
  };

  # DO NOT CHANGE. this is the first nixos version installed on this machine
  system.stateVersion = "25.05";
}
