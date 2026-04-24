{
  config, # read configs from other modules
  pkgs, # nixpkgs collection
  ... # ignore args passed to this module
}: {
  imports = [
    # include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  # bootloader & kernel
  boot = {
    # optimized kernel for latency/performance
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      systemd-boot = {
        # systemd for boot (faster for uefi)
        enable = true;

        # limit boot entries so it won't get cluttered
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    # set your hostname
    hostName = "c04o";

    # default wi-fi config for modern DE/WMs
    networkmanager.enable = true;
  };

  # set your timezone
  time.timeZone = "America/Managua";

  # change your inputs
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  # intel/irisxe config
  hardware.graphics = {
    # install mesa (opengl/vulkan)
    enable = true;

    # required for steam & 32-bit games
    enable32Bit = true;

    extraPackages = with pkgs; [
      # hardware video acceleration (va-api) for intel gpus
      intel-media-driver
    ];
  };

  services = {
    # allow apps to communicate with each other
    dbus.enable = true;

    printing.enable = true;

    # disable legacy pulseaudio
    pulseaudio.enable = false;

    # modern audio standard
    pipewire = {
      enable = true;

      # for apps using low-level alsa
      alsa.enable = true;
      alsa.support32Bit = true;

      # compatiblity layer so pulse apps also work
      pulse.enable = true;
    };

    # make sure gnome is off
    desktopManager.gnome.enable = false;

    # display/login
    xserver = {
      # not using x11 but wayland
      enable = false;

      # set your keyboard layout/var
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # login screen manager
    displayManager = {
      # gnome default
      gdm.enable = false;

      # simple desktop display manager
      sddm = {
        enable = true;

        # force it into wayland
        wayland.enable = true;
      };
    };
  };

  # prevent audio stutter
  security.rtkit.enable = true;

  # define a user account. set a password with 'passwd'
  users.users.coni = {
    isNormalUser = true;
    description = "coni";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  programs = {
    # Scrollable-tiling Wayland compositor
    niri.enable = true;

    # Z shell
    zsh.enable = true;

    # Optimise Linux system performance on demand
    gamemode.enable = true;

    # Fast cd command that learns your habits
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

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

    # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
    gnupg

    # Distributed version control system
    git

    # Grab images from a Wayland compositor
    grim

    # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    psmisc

    # Select a region in a Wayland compositor
    slurp

    # Extraction utility for archives compressed in .zip format
    unzip

    # Tool for retrieving files using HTTP, HTTPS, and FTP
    wget

    # Command-line copy/paste utilities for Wayland
    wl-clipboard

    # Xwayland (X server for interfacing X11 apps with the Wayland protocol) outside your Wayland compositor
    xwayland-satellite

    # Compressor/archiver for creating and modifying zipfiles
    zip
  ];

  fonts = {
    packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Inter"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
        ];
      };
    };
  };

  # create a bridge to run old x11 apps (steam) on niri as it doesn't support them
  systemd.user.services.xwayland-satellite = {
    description = "Xwayland Satellite";
    wantedBy = [
      "graphical-session.target"
    ];
    partOf = [
      "graphical-session.target"
    ];
    serviceConfig = {
      # un-set WAYLAND_DISPLAY so the satellite creates its own X11 display
      ExecStart = "${pkgs.coreutils}/bin/env -u WAYLAND_DISPLAY ${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "always";
    };
  };

  # auto garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    # delete generations older than 7 days
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
