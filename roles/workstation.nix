# The workstation role configures a machine with settings and command line tools
# expected to be on a workstation meant to get things done!

{ config, pkgs, ... }:

{
  # Automatically upgrade for easier maintenance
  system.autoUpgrade.enable = true;

  environment.variables = {
    EDITOR = "nvim";
  };

  # Enable fish with correct system environment
  programs.fish.enable = true;

  # Clear default shell aliases
  programs.bash.shellAliases = {};
  programs.fish.shellAliases = {};

  # Shell aliases (for all shells)
  environment.shellAliases = {
    vim = "nvim"; # Use neovim instead of vim
  };

  # Shells available to users
  environment.shells = [
    "/run/current-system/sw/bin/bash"
    "/run/current-system/sw/bin/fish"
  ];

  # Install minimal set of packages
  # Users can install more with nix-env
  environment.systemPackages = with pkgs; [
    git
    mosh
    neovim
    python
    tmux
  ];
}
