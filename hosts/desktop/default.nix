{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nvidia.nix
    ../../modules/desktop.nix
    ../../modules/gaming.nix
    ../../modules/apps.nix
  ];

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = pkgs.linuxPackages;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;
  hardware.enableRedistributableFirmware = true;
  time.timeZone = "America/New_York";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.kaw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "24.11";
}
