# fox - cloud workstation

{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
    ../common.nix
    ../roles/workstation.nix
    ../users/kiba.nix
  ];

  networking = {
    hostName = "fox";
  };

  # Turn off support for X11
  environment.noXlibs = true;
}
