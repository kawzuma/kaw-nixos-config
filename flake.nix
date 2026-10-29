{
  description = "Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, ... }@inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/default.nix
          ./hosts/desktop/hardware.nix
          ./modules/nvidia.nix
          ./modules/desktop.nix
          ./modules/gaming.nix
          ./modules/apps.nix
        ];
      };
    };
  };
}
