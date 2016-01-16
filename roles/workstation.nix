{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shells / Terminal
    bash
    fish
    tmux

    # Source control
    git

    # Web
    wget
    curl
    lynx

    # SSH
    mosh

    # Email
    isync

    # Interpreters
    python    
  ];
}
