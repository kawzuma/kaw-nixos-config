{ config, pkgs, inputs, ... }:
{
  # Declarative Flatpak Configuration
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "com.github.tchx84.Flatseal"
      "org.vinegarhq.Sober"
    ];

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    uninstallUnmanaged = true;
  };

  # Native System Packages
  environment.systemPackages = with pkgs; [
    # Flake inputs

    # Packages
    brave-origin
    spotify
    equibop
    git
    gh
    fastfetch
    _7zz
    unzip
    zip
    kdePackages.ark
    curl
    nh
    fetch

    # Steam FHS Runner
    steam-run

    # Btrfs Tools
    snapper
    btrfs-progs
    btrfs-assistant

    # Theme Configuration Tools
    nwg-look
    libsForQt5.qt5ct
    kdePackages.qt6ct
    adwaita-qt
    adwaita-qt6
    arc-theme
  ];
}
