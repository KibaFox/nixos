# Redshift adjusts the color temperature of your screen according to your
# surroundings. This may help your eyes hurt less if you are working in front of
# the screen at night.  Inspired by f.lux.
#
# Website: http://jonls.dk/redshift/
# ArchWiki: https://wiki.archlinux.org/index.php/Redshift

{ config, pkgs, ... }:

{
  services.xserver = {
    displayManager.sessionCommands = ''
      ${pkgs.redshift}/bin/redshift &
    '';
  };

  environment.systemPackages = [
    pkgs.redshift
  ];
}
