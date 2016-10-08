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

  programs.tmux = {
    enable        = true;
    baseIndex     = 1;    # Match window index order with keyboard
    escapeTime    = 10;   # Prevent delay when switching modes w/ ESC in NeoVim
    historyLimit  = 5000; # Increase default history limit
    keyMode       = "vi"; # Use vi style shortcuts
    newSession    = true; # Create a new session if there isn't one to attach
    terminal      = "tmux-256color";
    extraTmuxConf = ''
      # Use vim motion keys to move between panes
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };

  # Install minimal set of packages
  # Users can install more with nix-env
  environment.systemPackages = with pkgs; [
    git
    mosh
    neovim
    python
  ];
}
