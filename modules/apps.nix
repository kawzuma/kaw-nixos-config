{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Packages
    brave-origin
    spotify
    equibop
    git
    gh
    fastfetch
    _7zz
    kdePackages.ark
    curl

    # Btrfs related
    snapper
    btrfs-progs
    btrfs-assistant

    # Theme configuration & styling tools for system-wide dark mode
    nwg-look
    libsForQt5.qt5ct
    kdePackages.qt6ct
    adwaita-qt
    adwaita-qt6
    arc-theme
  ];
}
