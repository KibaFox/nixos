# vbox - VirtualBox
#
# Setup steps:
#
#   mkfs.btrfs -L nixos /dev/sda
#   mount -o noatime,discard,space_cache /dev/sda /mnt
#   nixos-generate-config --root /mnt
#
#   nano /etc/nixos/hardware-configuration.nix
#   nano /etc/nixos/configuration.nix
#
#   nixos-install
#
# Btrfs occupies the entire drive in this setup, which disallows swap or 
# encryption, but VirtualBox supports encryption via an extension and 
# RAM can be easily adjusted.  Simplicity is chosen here.
#
# Compression isn't enabled during installation (suggested on the Arch 
# wiki).  Run the following post install to apply compression to the 
# installed files:
#
#   btrfs filesystem defragment -r -v clzo /mnt
#
# Note: this is best when performed before NixOS mounts the filesystem.

{ config, lib, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../roles/workstation.nix
    ../roles/graphical_workstation.nix
  ];

  networking = {
    hostName = "vbox";
    enableIPv6 = false;
  };

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "ohci_pci"
    "ehci_pci"
    "ahci"
  ];

  boot.kernelPackages = pkgs.linuxPackages_4_2;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = "noatime,discard,compress=lzo,space_cache";
  };

  nix.maxJobs = 4;
  virtualisation.virtualbox.guest.enable = true;
}
