{ config, pkgs, ... }:

{
  # Enable full acceleration for 32-bit programs
  # Some wine applications need this
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = [
    pkgs.mono             # Wine depends on mono for some applications
    pkgs.wine             # Runs Windows applications on Linux
  ];
}
