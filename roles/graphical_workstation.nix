{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.slim = {
      enable = true;
      autoLogin = true;
      defaultUser = "kiba";
    };

    displayManager.sessionCommands = ''
      ${pkgs.redshift}/bin/redshift &
    '';

    desktopManager = {
      # Disable the defaults.  Don't use a desktop manager or xterm.
      default = "none";
      xterm.enable = false;
    };

    windowManager = {
      default = "spectrwm";
      spectrwm.enable = true;
    };
  };

  # Hide the mouse cursor when not in use
  services.unclutter = {
    enable = true;
    arguments = "-idle 2";
  };

  # Fonts to include
  fonts.fonts = [
    pkgs.corefonts # Microsoft free fonts
    pkgs.source-code-pro
    pkgs.source-sans-pro
    pkgs.source-serif-pro
  ];

  # Default fonts
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Source Code Pro" ];
    sansSerif = [ "Source Sans Pro" ];
    serif = [ "Source Serif Pro" ];
  };

  environment.systemPackages = [
    # Browsers
    pkgs.chromium
    pkgs.firefox

    # Terminal
    pkgs.st

    # Menu
    pkgs.dmenu

    # Clipboard
    pkgs.xsel

    # Fake keyboard/mouse input, window management, and more
    pkgs.xdotool

    # Graphical lock
    pkgs.i3lock

    # Screenshot tool
    pkgs.maim

    # Image viewer
    pkgs.sxiv

    # Save my eyes at night with Redshift
    pkgs.redshift

    # Password store
    pkgs.keepassx2

    # Sync
    pkgs.dropbox-cli
  ];
}
