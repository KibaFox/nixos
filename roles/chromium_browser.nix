# Chromium web browser

{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.chromium
  ];

  nixpkgs.config.chromium = {
    enablePepperFlash = true;       # Some sites still need flash
    enableWideVine = true;          # Allows Netflix to be played on Linux
  };
}
