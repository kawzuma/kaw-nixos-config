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

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  networking.hostName = "desktop";
  time.timeZone = "America/New_York";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.kaw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "24.11";
}
