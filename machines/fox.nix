# fox - Desktop Workstation
#
# Uses Btrfs on the whole disk for simplicity.
# See `../doc/btrfs_whole_disk.md` for setup details.

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../bundles/desktop.nix
  ];

  networking = {
    hostName = "fox";
  };

  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "firewire_ohci"
    "pata_jmicron" 
    "usb_storage"
    "usbhid"
  ];

  boot.kernelModules = [
    "kvm-intel"
  ];

  boot.kernelPackages = pkgs.linuxPackages_4_3;

  boot.loader.grub.device = "/dev/sdb";

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "btrfs";
    options = [
      "ssd"
      "noatime"
      "discard"
      "compress=lzo"
      "space_cache"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/hdd";
    fsType = "btrfs";
    options = [
      "subvol=/home"
      "noatime"
      "discard"
      "compress=lzo"
      "space_cache"
    ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-label/hdd";
    fsType = "btrfs";
    options = [
      "subvol=/var"
      "noatime"
      "discard"
      "compress=lzo"
      "space_cache"
    ];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-label/hdd";
    fsType = "btrfs";
    options = [
      "subvol=/tmp"
      "noatime"
      "discard"
      "compress=lzo"
      "space_cache"
    ];
  };

  # Install proprietary NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  nixpkgs.config.allowUnfree = true;

  nix.maxJobs = 8;
}
