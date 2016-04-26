Btrfs on Whole Drive
====================

Installing Btrfs on the whole drive simplifies setup of a new system.  In this
setup, Btrfs occupies the entire storage device, including the partition table,
and Btrfs subvolumes can be used to simulate partitions.  There are some
limitations to this, however.

* You cannot use whole disk encryption (to my knowledge).
* You cannot create swap space since Btrfs doesn't support swap files and there
  is no room to create a swap partition.
* You cannot use UEFI to boot.

Setup
-----

The following are commands I used to set Btrfs up on the whole drive:

    mkfs.btrfs -L nixos /dev/sda
    mount -o discard,compress=lzo /dev/sda /mnt
    nixos-generate-config --root /mnt

    nano /etc/nixos/hardware-configuration.nix

When editing `/etc/nixos/hardware-configuration.nix` I include the following...

    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "discard" "compress=lzo" ];
    };

Then I continue with my configuration and run the NixOS install command.

    nano /etc/nixos/configuration.nix
    nixos-install

Before I restart, I apply compression to the installed files like so:

    btrfs filesystem defragment -r -v clzo /mnt

Compression isn't enabled during installation (a suggestion found on ArchWiki),
but will be enabled after reboot.

See Also
--------

* [Btrfs article on ArchWiki](https://wiki.archlinux.org/index.php/Btrfs)
