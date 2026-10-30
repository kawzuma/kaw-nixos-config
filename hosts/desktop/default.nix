{ config, pkgs, inputs, ... }:

let
  # Correctly build Darkly using Plasma 6 KDE packages
  darkly-qt6 = pkgs.kdePackages.callPackage "${inputs.darkly}/nix/package.nix" { };
in
{
  imports = [
    ./hardware.nix
    ../../modules/nvidia.nix
    ../../modules/desktop.nix
    ../../modules/gaming.nix
    ../../modules/apps.nix
  ];

  # CachyOS Kernel via overlay
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  # GRUB configuration with OS-prober for multi-boot support
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Store optimization & automatic garbage collection
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Automatic Snapper Btrfs snapshots for root and home
  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1d";
    configs = {
      root = {
        SUBVOLUME = "/";
        ALLOW_USERS = [ "kaw" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "2";
        TIMELINE_LIMIT_MONTHLY = "1";
      };
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "kaw" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "2";
        TIMELINE_LIMIT_MONTHLY = "1";
      };
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Install Darkly Qt6 Theme
  environment.systemPackages = [
    darkly-qt6
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.enableRedistributableFirmware = true;
  time.timeZone = "America/New_York";

  programs.fish.enable = true;

  users.users.kaw = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "24.11";
}
