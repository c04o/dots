{
  description = "my nixos dots";

  # define where the code is pulled from
  inputs = {
    # Elephant acts as a unified backend service that aggregates data from various sources (desktop applications, files, clipboard history, etc.)
    elephant.url = "github:abenz1267/elephant";

    # Manage a user environment using Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      # prevent duplicate packages
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-native configuration for niri
    niri.url = "github:sodiboo/niri-flake";

    # Modular, extensible and distro-agnostic Neovim configuration framework for Nix/NixOS
    nvf.url = "github:NotAShelf/nvf";

    # Nix Packages collection & NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Multi-Purpose Launcher with a lot of features. Highly Customizable and fast.
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    # Community-driven Nix Flake for the Zen browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    # defined above
    elephant,
    home-manager,
    niri,
    nvf,
    nixpkgs,
    walker,
    zen-browser,
    ...
  } @ inputs: let
    # capture all inputs into a variable for easy passing
    # import for passing colorscheme, fonts
    theme = import ./theme/default.nix;
  in {
    # define and name the system
    # trigger this build with 'nixos-rebuild switch --flake .#c04o'
    nixosConfigurations."c04o" = nixpkgs.lib.nixosSystem {
      # intel/amd 64-bit architecture
      system = "x86_64-linux";

      # pass inputs to all modules (configuration.nix)
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix

        # hook Home Manager into the build process
        home-manager.nixosModules.home-manager
        {
          # use the system's package list (saves disk space)
          home-manager.useGlobalPkgs = true;

          # install packages to /etc/profiles instead of ~/.nix-profile
          home-manager.useUserPackages = true;

          # import user config
          home-manager.users.coni = import ./home.nix;

          # let home-manager files use theme
          home-manager.extraSpecialArgs = {inherit inputs theme;};

          # if an existing config file conflicts, rename it to .backup instead of failing
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
