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

    # Tools
    pkgs.dmenu
  ];
}
