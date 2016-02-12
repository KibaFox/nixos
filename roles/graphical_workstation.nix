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
    arguments = "-idle 2 -noevents";
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
    (pkgs.st.override { conf = builtins.readFile ../config/st/config.def.h; })
    pkgs.chromium
    pkgs.dmenu
    pkgs.dropbox-cli      # File sync
    pkgs.firefox
    pkgs.i3lock
    pkgs.keepass          # Password store
    pkgs.maim             # Screenshot tool
    pkgs.redshift         # Save my eyes at night
    pkgs.sxiv             # Image viewer
    pkgs.xdotool          # Fake keyboard/mouse input, window management
    pkgs.xsel             # Clipboard manipulation
  ];

  nixpkgs.config.chromium = {
    enablePepperFlash = true;       # Some sites still need flash
    enableWideVine = true;          # Allows Netflix to be played on Linux
  };
}
