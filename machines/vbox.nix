# vbox - VirtualBox
#
# Uses Btrfs on the whole disk for simplicity.
# See `../doc/btrfs_whole_disk.md` for setup details.

{ config, lib, pkgs, ... }:

{
  imports = [
    ../roles/workstation.nix
    ../roles/graphical_workstation.nix
    ../roles/qute_browser.nix
    ../roles/canto_rss_user.nix
    ../roles/gocoder.nix
    ../roles/phoenix_coder.nix
    ../roles/pia.nix
  ];

  system.stateVersion = "16.09";

  networking = {
    hostName = "vbox";
  };

  time.timeZone = "America/New_York";

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

  # Disable need for entering password into sudo
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;

  # Install proprietary NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  nix.maxJobs = 2;
  virtualisation.virtualbox.guest.enable = true;
}
