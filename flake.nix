{
  description = "Kaw's Modular NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Declarative Flatpak module
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # Darkly theme flake input
    darkly = {
      url = "github:Bali10050/Darkly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Link nix-cachyos-kernel to main nixpkgs
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, darkly, nix-cachyos-kernel, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
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
