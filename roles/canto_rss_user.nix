# Canto is an Atom/RSS feed reader for the console that is meant to be quick,
# concise, and colorful.
#
# Manual: http://codezen.org/canto-ng/manual/

{ config, pkgs, ... }:

{
  services.canto-daemon.enable = true;
  environment.systemPackages = [
    pkgs.canto-curses
    pkgs.canto-daemon
  ];
}
