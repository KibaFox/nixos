# The graphical workstation role configures a machine with settings and
# graphical tools expected to be on a workstation meant to get things done!

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
      default = "i3";
      i3.enable = true;
    };
  };

  # Hide the mouse cursor when not in use
  services.unclutter = {
    enable = true;
    arguments = "-idle 2 -noevents";
  };

  # Fonts to include
  fonts.fonts = [
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
    pkgs.conky
    pkgs.dmenu            # Fast and lightweight dynamic menu for X
    pkgs.dropbox-cli      # File sync
    pkgs.firefox
    pkgs.i3lock
    pkgs.i3status
    pkgs.keepassx2        # Password store
    pkgs.maim             # Screenshot tool
    pkgs.mpv              # A media player that supports many video formats
    pkgs.pinta            # Drawing/editing program modeled after Paint.NET
    pkgs.playerctl        # Command-line utility for controlling media players
    pkgs.sxiv             # Image viewer
    pkgs.xdotool          # Fake keyboard/mouse input, window management
    pkgs.xfontsel         # X11 font selection tool
    pkgs.xorg.xbacklight  # Adjusts screen brightness
    pkgs.xsel             # Clipboard manipulation
  ];
}
