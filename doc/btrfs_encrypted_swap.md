Btrfs with Encryption and Swap
==============================

This setup allows you to have Btrfs and swap space, with both encrypted.  This
is accomplished by encapsulating the Btrfs and swap volumes in LVM and
encrypting the partition containing LVM.

These steps assume a single solid state drive.

Setup
-----

First use `lsblk` command to find which device is the primary disk.  In this
example, we've identified `sda` as the primary disk.

First we need to partition our disk.  I prefer to use `gdisk` for this task.

    gdisk /dev/sda

This start an interactive session with `gdisk`, so what follows are the
commands I give to `gdisk` to partition my disk.

Clear everything and write the partition table.

    o
    y

Create a partition to be mounted at `/boot` of type *Linux filesystem* (8300)
with a size of 256 MB.

    n
    <Enter>
    <Enter>
    256M
    8300

Create a partition of type *Linux LVM* (8e00), which will later contain the
encrypted container.

    n
    <Enter>
    <Enter>
    <Enter>
    8e00

Create the *BIOS boot Partition* (ef02).

    n
    <Enter>
    34
    <Enter>
    ef02

You can print the table to check your work.

    p

When you are finished, write table to disk and exit.

    w
    y

At this point you should be back in the shell.

Next, create the LUKS encrypted container on the system partition. You will be
prompted for a password twice.

    cryptsetup luksFormat /dev/sda2

Open the container and map it with the name *lvm*.

    cryptsetup open --type luks /dev/sda2 lvm

Create an LVM physical volume on top of the opened LUKS container:

    pvcreate /dev/mapper/lvm

Create the LVM volume group named *hostname1* (use your computer's hostname),
adding the previously created physical volume to it:

    vgcreate hostname1 /dev/mapper/lvm

Create the swap and root as logical volumes on the volume group.  In this
example I set aside *9GB* of swap and will use the rest for my root filesystem.
The hibernation feature needs the swap to be the same size as the physical
memory at minimum to work.  I don't usually use the hibernation feature, but
I like to have enough space and a little extra just in case.  Adjust this
to your your liking.  I recommend at least having 1GB of swap for most cases.

    lvcreate -L 9G hostname1 -n swap
    lvcreate -l 100%FREE hostname1 -n root

At this point, if you reboot, you will need to run the following commands to
get to your logical volumes again:

    cryptsetup open --type luks /dev/sda2 lvm
    vgchange -ay hostname1

The `cryptsetup open` command will unlock your encrypted partition and the
`vgchange` command activates the volume group, allowing you to see the logical
volumes in `/dev/mapper` again.

Next, we format the filesystems on each logical volume:

    mkfs.btrfs /dev/mapper/hostname1-root
    mkswap /dev/mapper/hostname1-swap

Now, mount the filesystems:

    mount -o discard,compress=lzo /dev/mapper/hostname1-root /mnt
    swapon /dev/mapper/hostname1-swap

Create an *Ext2* filesystem on the partition intended for /boot. Any filesystem
that can be read by the bootloader is usable, but this keeps it simple.

    mkfs.ext2 -L boot /dev/sda1

Create the directory `/mnt/boot`:

    mkdir /mnt/boot

Mount the partition to `/mnt/boot`:

    mount /dev/disk/by-label/boot /mnt/boot

Generate the initial NixOS configuration files:

    nixos-generate-config --root /mnt

This will generate the following:

  * `/mnt/etc/nixos/configuration.nix`
  * `/mnt/etc/nixos/hardware-configuration.nix`

Edit `hardware-configuration.nix` with `nano`:

    nano /mnt/etc/nixos/hardware-configuration.nix

When editing `hardware-configuration.nix` I include the following...

    boot.initrd.luks.devices = [{
      name = "luksroot";
      device = "/dev/sda2";
      allowDiscards = true;
    }];

    fileSystems."/" = {
      device = "/dev/mapper/hostname1-root";
      fsType = "btrfs";
      options = [ "discard" "compress=lzo" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "ext2";
    };

    swapDevices = [
      { device = "/dev/mapper/hostname1-swap"; }
    ];

You may want to make a few adjustments of your own, and don't forget to replace
*hostname1* with the name you have chosen for your LVM volumes.

If you do not have a solid state drive, you can remove the `allowDiscards` from
the `boot.initrd.luks.devices` section and remove `discard` from the btrfs mount
options in the `fileSystems."/"` section.

The next step is to edit `configuration.nix` to include a minimal setup to
install.  I've created a bootstrap configuration for this purpose.  The
following will replace `configuration.nix` with my bootstrap configuration:

    curl -o /mnt/etc/nixos/configuration.nix \
    https://raw.githubusercontent.com/KibaFox/nixos/master/bootstrap.nix

My bootstrap file configures the GRUB bootloader, installs `git`, and creates my
personal user, *kiba*.  I add my user to the *wheel* group, which allows me to
use `sudo` as my user.  Installing `git` will allow me to grab my personal
[nixos][my-nixos] configuration and [dotfiles][my-dotfiles] once NixOS is
installed.

[my-nixos]: https://github.com/KibaFox/nixos
[my-dotfiles]: https://github.com/KibaFox/dotfiles

After setting up your `configuration.nix`, it's finally time to install...

    nixos-install

See Also
--------

* [Btrfs article on ArchWiki](https://wiki.archlinux.org/index.php/Btrfs)
* [dm-crypt article on ArchWiki](https://wiki.archlinux.org/index.php/Dm-crypt)
* [dm-crypt/Encrypting an entire system on ArchWiki](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system)
