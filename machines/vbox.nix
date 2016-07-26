# vbox - VirtualBox
#
# Uses Btrfs on the whole disk for simplicity.
# See `../doc/btrfs_whole_disk.md` for setup details.

{ config, lib, pkgs, ... }:

{
  imports = [
    ../bundles/vdesktop.nix
  ];

  networking = {
    hostName = "vbox";
  };

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "ohci_pci"
    "ehci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
  ];

  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [ "discard" "compress=lzo" ];
  };

  nixpkgs.config.allowUnfree = true;

  # Install proprietary NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  nix.maxJobs = 2;
  virtualisation.virtualbox.guest.enable = true;
}
