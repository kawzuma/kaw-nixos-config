{ config, pkgs, inputs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    heroic
    mangohud
    protonplus
    wineWow64Packages.stable

    # PineconeMC package from flake input
    inputs.pineconemc.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
