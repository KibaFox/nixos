# The workstation role configures a machine with settings and command line tools
# expected to be on a workstation meant to get things done!

{ config, pkgs, ... }:

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

  services.physlock = {
    enable = true;
  };

  environment.systemPackages = [
    pkgs.bash
    pkgs.bind             # Provides nslookup, dig
    pkgs.ctags
    pkgs.curl
    pkgs.dos2unix         # Convert between dos and unix line endings
    pkgs.fish
    pkgs.git              # Source control
    pkgs.htop
    pkgs.isync            # Email sync, an alternative to OfflineIMAP
    pkgs.lsof             # Tool to list open files
    pkgs.mosh             # The mobile shell
    pkgs.neovim           # Neovim, my editor of choice
    pkgs.pandoc           # Universal document converter
    pkgs.pngnq            # Lossy PNG compressor
    pkgs.psmisc           # includes killall
    pkgs.pwgen            # Password generator
    pkgs.python
    pkgs.python3
    pkgs.silver-searcher
    pkgs.tmux
    pkgs.unzip
    pkgs.wget
    pkgs.which            # Some programs depend on this
  ];
}
