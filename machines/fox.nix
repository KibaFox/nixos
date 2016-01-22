# fox - Desktop Workstation
#
# Uses Btrfs on the whole disk for simplicity.
# See `../doc/btrfs_whole_disk.md` for setup details.

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../common.nix
    ../roles/workstation.nix
    ../roles/graphical_workstation.nix
  ];

  networking = {
    hostName = "fox";
    enableIPv6 = false;
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

  boot.kernelPackages = pkgs.linuxPackages_4_2;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = "noatime,discard,compress=lzo,space_cache";
  };

  nix.maxJobs = 8;
}
