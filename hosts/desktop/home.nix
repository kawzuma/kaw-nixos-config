{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/fish.nix
    ../../modules/home/git.nix
    ../../modules/home/theme.nix
    ../../modules/home/cli.nix
  ];

  home.username = "kaw";
  home.homeDirectory = "/home/kaw";

  programs.home-manager.enable = true;

  # Declarative Fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # Declarative Cursor Theme
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  home.stateVersion = "26.11";
}
