{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # bootloader & kernel
  boot = {
    # optimized kernel for latency/performance
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = {
        enable = true; # systemd for boot (faster for UEFI)
        configurationLimit = 5; # limit boot entries in menu
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "c04o"; # set your hostname
    networkmanager.enable = true; # default wi-fi config for modern DEs/WMs
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

    # display/login
    xserver = {
      # not using x11 but wayland
      enable = false;

      # set your keyboard layout/var
      xkb = {
        layout = "us";
        variant = "";
      };

      # make sure gnome is off
      desktopManager.gnome.enable = false;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yourusername = {
    isNormalUser = true;
    description = "coni";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
      git
      vscode
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    htop
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05"; # Did you read the comment?
}
