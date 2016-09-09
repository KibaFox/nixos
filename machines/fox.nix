# fox - cloud workstation

{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix> ];

  networking = {
    hostName = "fox";
  };

  # Install minimal packages needed for provisioning
  environment.systemPackages = with pkgs; [
    fish
    git
    mosh
    neovim
    python
    python3
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
