# Tools for Elixir coders

{ config, pkgs, ... }:

{
  services.postgresql.enable = true;

  environment.systemPackages = [
    pkgs.elixir
    pkgs.nodejs-5_x
    pkgs.inotify-tools

    # To compile dependencies
    pkgs.gcc
    pkgs.gnumake
  ];
}
