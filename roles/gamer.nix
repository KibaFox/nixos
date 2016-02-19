# The gamer role sets up the computer to run games.

{ config, pkgs, ... }:

let
  neopkgs = import ../mypkgs/neopkgs.nix {
    # Steam is proprietary, so we must explicitly allow it
    config.allowUnfree = true;
  };
in
{
  # Steam also needs 32bit driver support
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = [
    neopkgs.steam
  ];
}
