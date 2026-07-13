{
  description = "NixOS niri rice";

  nixConfig = {
    extra-substituters = [
      "https://niri.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    # Nix Packages collection & NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # ❄️ Simplify Nix Flakes with the module system
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Import all nix files in a directory tree.
    import-tree.url = "github:vic/import-tree";

    # Manage a user environment using Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Flake for Helium browser. Auto updates, Policy support, NixOS module, Home-manager module
    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-native configuration for niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A sleek and minimal desktop shell thoughtfully crafted for Wayland.
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # Modular, extensible and distro-agnostic Neovim configuration framework for Nix/NixOS
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs: let
    # load your theme globally once
    theme = import ./themes/everforest.nix;
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];

      # pass 'theme' to everything processed by (import-tree ./modules)
      _module.args = {inherit theme;};

      systems = ["x86_64-linux"];

      flake = {
        nixosConfigurations.c04o = inputs.nixpkgs.lib.nixosSystem {
          # pass 'theme' to traditional nixos files (like configuration.nix)
          specialArgs = {inherit inputs theme;};
          modules = [
            {
              nixpkgs.overlays = [inputs.niri.overlays.niri];

              nix.settings = {
                extra-substituters = [
                  "https://walker.cachix.org"
                  "https://walker-git.cachix.org"
                ];
                extra-trusted-public-keys = [
                  "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
                  "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
                ];
              };
            }
            # host config paths
            ./hosts/c04o/configuration.nix
            ./hosts/c04o/hardware-configuration.nix

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # pass 'theme' to the runtime home manager evaluation layer
              home-manager.extraSpecialArgs = {inherit inputs theme;};

              # assign user config directly to module path
              home-manager.users.coni = import ./modules/home.nix;
            }
          ];
        };
      };
    };
}
