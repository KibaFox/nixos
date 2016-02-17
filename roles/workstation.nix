{ config, pkgs, ... }:

let
  neopkgs = import ../mypkgs/neopkgs.nix { };
in
{
  users.extraUsers.kiba = {
    description = "Kiba Fox";
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    uid = 1000;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = [
    neopkgs.fish
    neopkgs.neovim        # Neovim, my editor of choice
    pkgs.bash
    pkgs.curl
    pkgs.dos2unix         # Convert between dos and unix line endings
    pkgs.git              # Source control
    pkgs.htop
    pkgs.isync            # Email sync, an alternative to OfflineIMAP
    pkgs.lynx
    pkgs.mosh             # The mobile shell
    pkgs.pngnq            # Lossy PNG compressor
    pkgs.psmisc           # includes killall
    pkgs.pwgen            # Password generator
    pkgs.python
    pkgs.silver-searcher
    pkgs.tmux
    pkgs.wget
    pkgs.which            # Some programs depend on this
  ];
}
