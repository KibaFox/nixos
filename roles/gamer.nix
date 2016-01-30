{ config, pkgs, ... }:

{
  # Steam is proprietary, so we must explicitly allow it
  nixpkgs.config.allowUnfree = true;

  # Steam also needs 32bit driver support
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = [
    pkgs.steam
  ];
}
