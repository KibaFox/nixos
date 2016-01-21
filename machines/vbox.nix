# vbox - VirtualBox
#
# Uses Btrfs on the whole disk for simplicity.
# See `../doc/btrfs_whole_disk.md` for setup details.


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
