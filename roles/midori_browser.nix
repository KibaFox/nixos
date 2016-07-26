# Midori web browser

{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.gnome3.adwaita-icon-theme
    pkgs.gnome3.dconf
    pkgs.hicolor_icon_theme
    pkgs.midori
  ];
}
