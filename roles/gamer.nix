# The gamer role sets up the computer to run games.

{ config, pkgs, ... }:

{
  # Steam also needs 32bit driver support
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = [
    pkgs.steam
  ];
}
