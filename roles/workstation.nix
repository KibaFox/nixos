# The workstation role configures a machine with settings and command line tools
# expected to be on a workstation meant to get things done!

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

  # Automatically upgrade for easier maintenance
  system.autoUpgrade.enable = true;

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = [
    neopkgs.fish
    neopkgs.neovim        # Neovim, my editor of choice
    pkgs.bash
    pkgs.ctags
    pkgs.curl
    pkgs.dos2unix         # Convert between dos and unix line endings
    pkgs.git              # Source control
    pkgs.htop
    pkgs.isync            # Email sync, an alternative to OfflineIMAP
    pkgs.mosh             # The mobile shell
    pkgs.pandoc           # Universal document converter
    pkgs.pngnq            # Lossy PNG compressor
    pkgs.psmisc           # includes killall
    pkgs.pwgen            # Password generator
    pkgs.python
    pkgs.python3
    pkgs.silver-searcher
    pkgs.tmux
    pkgs.wget
    pkgs.which            # Some programs depend on this
  ];
}
