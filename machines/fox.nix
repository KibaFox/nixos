# fox - cloud workstation

{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix> ];

  networking = {
    hostName = "fox";
  };

  # Turn off support for X11
  environment.noXlibs = true;

  # Install minimal set of packages
  # Users can install more with nix-env
  environment.systemPackages = with pkgs; [
    git
    mosh
    neovim
    python
    tmux
  ];

  # Shells available to users
  environment.shells = [
    "/run/current-system/sw/bin/bash"
    "/run/current-system/sw/bin/fish"
  ];

  # Enable fish with correct system environment
  programs.fish.enable = true;

  # Create my personal user
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
