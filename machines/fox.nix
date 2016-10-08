# fox - cloud workstation

{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
    ../roles/workstation.nix
    ../users/kiba.nix
  ];

  system.stateVersion = "16.03";

  networking = {
    hostName = "fox";
  };

  time.timeZone = "America/New_York";

  # Turn off support for X11
  environment.noXlibs = true;
}
