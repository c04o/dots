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
    "/share/xdg-dekstop-portal"
  ];

  services = {
    displayManager.ly.enable = true;
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
    fish.enable = true;
    niri.enable = true;
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
    ];
    trusted-public-keys = [
      "niri.cachix.org-1:WvSGALzHlDmGqndxl3vO111xKyCaYK4RztZYRQHIfXw="
    ];
  };

  # DO NOT CHANGE. this is the first nixos version installed on this machine
  system.stateVersion = "25.05";
}
