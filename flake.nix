{
  description = "NixOS niri rice";

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

    # get dms plugins
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Modular, extensible and distro-agnostic Neovim configuration framework for Nix/NixOS
    nvf.url = "github:notashelf/nvf";

    # ❄️ Soothing pastel theme for Nix
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];

      systems = ["x86_64-linux"];

      flake = {
        nixosConfigurations.c04o = inputs.nixpkgs.lib.nixosSystem {
          # pass 'theme' to traditional nixos files (like configuration.nix)
          specialArgs = {inherit inputs;};
          modules = [
            # host config paths
            ./hosts/c04o/configuration.nix
            ./hosts/c04o/hardware-configuration.nix

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # pass 'theme' to the runtime home manager evaluation layer
              home-manager.extraSpecialArgs = {inherit inputs;};

              # assign user config directly to module path
              home-manager.users.coni = import ./modules/home.nix;
            }
          ];
        };
      };
    };
}
