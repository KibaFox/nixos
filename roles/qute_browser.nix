# qutebrowser - a keyboard-focused browser with a minimal GUI
# https://www.qutebrowser.org/

{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.qutebrowser
  ];
}
