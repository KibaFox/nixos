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

  environment.systemPackages = with pkgs; [
    (gnupg.override {
      pinentry = pinentry_ncurses;
      x11Support = false;
    })
    bash
    bind            # Provides nslookup, dig
    ctags
    curl
    dos2unix        # Convert between dos and unix line endings
    fish
    git             # Source control
    htop
    isync           # Email sync, an alternative to OfflineIMAP
    lsof            # Tool to list open files
    mosh            # The mobile shell
    neovim          # Neovim, my editor of choice
    pandoc          # Universal document converter
    pngnq           # Lossy PNG compressor
    psmisc          # includes killall
    pwgen           # Password generator
    python
    python3
    silver-searcher
    tmux
    unzip
    wget
    which           # Some programs depend on this
  ];
}
