{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave-origin
    spotify
    equibop
    git
    gh
    fastfetch
    _7zz
    kdePackages.ark
    curl
  ];
}
