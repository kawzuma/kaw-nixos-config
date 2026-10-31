{ config, pkgs, inputs, ... }:

{
  home.packages = [
    inputs.darkly.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "darkly";
  };
}
