{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
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
