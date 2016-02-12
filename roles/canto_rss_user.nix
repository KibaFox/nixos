{ config, pkgs, ... }:

{
  services.canto-daemon.enable = true;
  environment.systemPackages = [
    pkgs.canto-curses
    pkgs.canto-daemon
  ];
}
