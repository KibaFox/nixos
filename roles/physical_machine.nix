# Configuration for physical machines

{ config, pkgs, ... }:

{
  services.physlock = {
    enable = true;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
}
