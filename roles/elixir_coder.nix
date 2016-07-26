# Tools for Elixir coders

{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.elixir
  ];
}
