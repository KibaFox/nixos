# garou - Thinkpad T530

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../hardware/thinkpad_t530.nix
    ../roles/graphical_workstation.nix
    ../roles/physical_machine.nix
    ../roles/qute_browser.nix
    ../roles/redshift.nix
    ../roles/workstation.nix
    ../users/kiba.nix
  ];

  system.stateVersion = "16.09";

  networking = {
    hostName = "garou";
    wireless.enable = true;
  };

  time.timeZone = "America/New_York";

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ata_piix"
    "firewire_ohci"
    "usb_storage"
  ];

  boot.kernelModules = [
    "kvm-intel"
  ];

  boot.loader.grub.device = "/dev/sda";

  boot.initrd.luks.devices = [{
    name = "luksroot";
    device = "/dev/sda2";
    allowDiscards = true;
  }];

  fileSystems."/" = {
    device = "/dev/mapper/garou1-root";
    fsType = "btrfs";
    options = [ "discard" "compress=lzo" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "ext2";
  };

  swapDevices = [
    { device = "/dev/mapper/garou1-swap"; }
  ];

  nixpkgs.config.allowUnfree = true;

  nix.maxJobs = 4;
}
