# fox - cloud workstation

{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix> ];

  networking = {
    hostName = "fox";
  };

  # Install minimal packages needed for provisioning
  environment.systemPackages = with pkgs; [
    (gnupg.override {
      pinentry = pinentry_ncurses;
      x11Support = false;
    })
    emacs24-nox
    fish
    git
    gnupg
    mosh
    neovim
    python
    python3
    tmux
    vimNox
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
