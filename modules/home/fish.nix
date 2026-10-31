{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      update = "nh os switch ~/.config/nixos";
      clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      ls = "eza --icons";
      ll = "eza -l --icons --git";
      cat = "bat";
    };
  };
}
