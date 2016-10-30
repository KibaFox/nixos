# Thinkpad T530
#
# ArchWiki - ThinkPad T530
# Gives some T530 specific help.
# https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_T530
#
# ArchWiki - ThinkPad T420
# Gives more detailed hints and tips that apply to the T530 as well
# https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_T420
#
# Note: The tp_smapi module does not support the T530.  However, there is a
# thinkpad-acpi module, but NixOS does not have this yet.  There is a utility
# called tpacpi-bat that will allow you to change battery thresholds without
# tp_smapi.

{ config, lib, pkgs, ... }:

{
  # Power saving options
  # https://www.phoronix.com/scan.php?page=article&item=intel_i915_power&num=1%7C
  boot.kernelParams = [
    "i915.i915_enable_rc6=1"
    "i915.i915_enable_fbc=1"
    "i915.lvds_downclock=1"
    "i915.semaphores=1"
    "rcutree.rcu_idle_gp_delay=1"
  ];

  services.thinkfan = {
    enable = true;
    sensor = "/sys/devices/virtual/thermal/thermal_zone0/temp";
  };

  hardware.trackpoint = {
    enable       = true;
    fakeButtons  = true; # Enables the bottom touch pad
    emulateWheel = true; # Hold middle mouse button for wheel
  };

  # Enable light to control the backlight of the screen
  programs.light.enable = true;

  # NVIDIA Optimus support via Bumblebee
  hardware.bumblebee.enable = true;
  hardware.bumblebee.connectDisplay = true;
  #hardware.bumblebee.driver = "nouveau";

  # Attempt to fix (does not work, however):
  # /dev/dri/card0: failed to set DRM interface version 1.4: Permission denied
  services.xserver.config = ''
    Section "Screen"
      Identifier "Default Screen"
      Device "DiscreteNvidia"
    EndSection
  '';

  hardware.opengl.driSupport32Bit = true;
}
