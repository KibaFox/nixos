{ config, pkgs, ... }:

{
  time.timeZone = "America/New_York";

  environment.systemPackages = [
    pkgs.git
  ];

  system.stateVersion = "16.03";
}
