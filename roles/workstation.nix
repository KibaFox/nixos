{ config, pkgs, ... }:

let
  neopkgs = import ../mypkgs/neopkgs.nix { };
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
    pkgs.isync            # Email sync, an alternative to OfflineIMAP
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
