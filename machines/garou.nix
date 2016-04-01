# garou - Thinkpad T530

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../bundles/vdesktop.nix
    ../roles/redshift.nix
  ];

  networking = {
    hostName = "garou";
    wireless.enable = true;
  };

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ata_piix"
    "firewire_ohci"
    "usb_storage"
  ];

  boot.kernelModules = [
    "kvm-intel"
    "tp_smapi"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.tp_smapi
  ];

  boot.kernelPackages = pkgs.linuxPackages_4_3;

  boot.loader.grub.device = "/dev/sda";

  boot.initrd.luks.devices = [{
    name = "luksroot";
    device = "/dev/sda2";
    allowDiscards = true;
  }];

  fileSystems."/" = {
    device = "/dev/mapper/garou1-root";
    fsType = "btrfs";
    options = "discard,compress=lzo";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "ext2";
  };

  swapDevices = [
    { device = "/dev/mapper/garou1-swap"; }
  ];

  hardware.trackpoint = {
    enable = true;
    fakeButtons = true;
    emulateWheel = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.maxJobs = 4;
}
