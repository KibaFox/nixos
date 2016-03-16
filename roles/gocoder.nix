# Tools for go coders

{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.go
  ];
}
