# Tools for go coders

{ config, pkgs, ... }:

let
  neopkgs = import ../mypkgs/neopkgs.nix {};
in
{
  environment.systemPackages = [
    neopkgs.go
  ];
}
