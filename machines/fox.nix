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

  # Create my personal user
  users.extraUsers.kiba = {
    description = "Kiba Fox";
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    uid = 1000;
  };
}
