{
  description = "Kaw's Modular NixOS Flake Configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.lantian.pub/lantian"
      "https://prismlauncher.cachix.org"
    ];
    extra-trusted-public-keys = [
      "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Declarative Flatpak module
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # Darkly theme flake input
    darkly = {
      url = "github:Bali10050/Darkly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Link nix-cachyos-kernel without forcing follows so binary cache works
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # PineconeMC Flake Input
    pineconemc.url = "github:ElyPrismLauncher/Launcher";

    # Home Manager Input
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, darkly, nix-cachyos-kernel, pineconemc, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kaw = import ./hosts/desktop/home.nix;
          }
          ./hosts/desktop/default.nix
        ];
      };
    };
  };
}
