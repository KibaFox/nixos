# The graphical workstation role configures a machine with settings and
# graphical tools expected to be on a workstation meant to get things done!

{ config, pkgs, ... }:

let
  custompkgs = import ../mypkgs/custompkgs.nix { };
in
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

  # Hide the mouse cursor when not in use
  services.unclutter = {
    enable = true;
    arguments = "-idle 2 -noevents";
  };

  # Fonts to include
  fonts.fonts = [
    pkgs.corefonts # Microsoft free fonts
    pkgs.dina-font
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
    custompkgs.st
    pkgs.chromium
    pkgs.conky
    pkgs.dmenu
    pkgs.dropbox-cli      # File sync
    pkgs.firefox
    pkgs.i3lock
    pkgs.keepassx2        # Password store
    pkgs.maim             # Screenshot tool
    pkgs.pinta            # Drawing/editing program modeled after Paint.NET
    pkgs.sxiv             # Image viewer
    pkgs.xdotool          # Fake keyboard/mouse input, window management
    pkgs.xfontsel         # X11 font selection tool
    pkgs.xsel             # Clipboard manipulation
  ];

  nixpkgs.config.chromium = {
    enablePepperFlash = true;       # Some sites still need flash
    enableWideVine = true;          # Allows Netflix to be played on Linux
  };
}
