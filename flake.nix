{
  description = "my dots";

  # define where the code is pulled from
  inputs = {
    # Nix Packages collection & NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Community-driven Nix Flake for the Zen browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    # defined above
    nixpkgs,
    zen-browser,
    ...
  }: {
    nixosConfigurations."c04o" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
