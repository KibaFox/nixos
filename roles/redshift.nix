{ config, pkgs, ... }:

{
  services.xserver = {
    displayManager.sessionCommands = ''
      ${pkgs.redshift}/bin/redshift &
    '';
  };

  environment.systemPackages = [
    pkgs.redshift         # Save my eyes at night
  ];
}
