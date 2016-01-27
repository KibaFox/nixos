{ config, pkgs, ... }:

let
  neopkgs = import (
    pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "8f793ce6bb050252e92a987cc3c5bd48d5423a42";
      sha256 = "0fydxirp79s4svr2gadp3hsx2vrank904n8c5kprqh3jrzid90cg";
    }
  ) {};
in
{
  environment.variables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = [
    neopkgs.neovim        # Neovim, my editor of choice
    pkgs.bash
    pkgs.curl
    pkgs.dos2unix         # Convert between dos and unix line endings
    pkgs.fish
    pkgs.git              # Source control
    pkgs.htop
    pkgs.inetutils        # Common net utils
    pkgs.isync            # Email MTA that is an alternative to OfflineIMAP
    pkgs.lynx
    pkgs.mosh             # The mobile shell
    pkgs.psmisc           # includes killall
    pkgs.pwgen            # Password generator
    pkgs.python
    pkgs.silver-searcher
    pkgs.tmux
    pkgs.wget
    pkgs.which            # Some programs depend on this
  ];
}
