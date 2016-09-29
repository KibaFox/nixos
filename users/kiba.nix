# Configuration for my personal user

{ config, pkgs, ... }:

{
  users.extraUsers.kiba = {
    description = "Kiba Fox";
    isNormalUser = true;
    shell = "/run/current-system/sw/bin/fish"; # Make fish my default shell
    extraGroups = [
      "wheel"
    ];
    uid = 1000;
  };
}
