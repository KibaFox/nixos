# cheval - workhorse desktop
# Dell Studio XPS 435T / 9000

{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    #../hardware/pulseaudio.nix
    ../roles/graphical_workstation.nix
    ../roles/physical_machine.nix
    ../roles/qute_browser.nix
    ../roles/redshift.nix
    ../roles/workstation.nix
    ../users/kiba.nix
  ];

  system.stateVersion = "16.09";

  networking = {
    hostName = "cheval";
    wireless.enable = true;
  };

  time.timeZone = "America/New_York";

  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "firewire_ohci"
    "pata_jmicron"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];

  boot.kernelModules = [
    "kvm-intel"
  ];

  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.extraEntries = ''
    menuentry "Windows 10" {
      set root='hd1'
      chainloader +1
    }
  '';

  boot.initrd.luks.devices = [{
    name = "luksroot";
    device = "/dev/sda2";
    allowDiscards = true;
  }];

  fileSystems."/" = {
    device = "/dev/mapper/cheval1-root";
    fsType = "btrfs";
    options = [ "discard" "compress=lzo" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "ext2";
  };

  swapDevices = [
    { device = "/dev/mapper/cheval1-swap"; }
  ];

  # Default to using headset w/ USB sound card
  sound.extraConfig = ''
    defaults.pcm.!card 2
    defaults.ctl.!card 2
  '';

  # Set primary display
  services.xserver.displayManager.sessionCommands = ''
    xrandr --output DVI-I-1 --primary
  '';

  # Enable nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  nixpkgs.config.allowUnfree = true;

  nix.maxJobs = lib.mkDefault 8;
}
