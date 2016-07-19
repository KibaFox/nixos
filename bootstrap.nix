# Bootstrap - Use this to replace the default configuration.nix that comes from
# running nixos-generate-config.  You can run the following:
#
#   curl -o /mnt/etc/nixos/configuration.nix \
#       https://raw.githubusercontent.com/KibaFox/nixos/master/bootstrap.nix
#
# After this, edit /mnt/etc/nixos/hardware-configuration.nix appropriately then
# run nixos-install.

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Install minimal packages needed for provisioning
  environment.systemPackages = with pkgs; [
    git
  ];

  # Create my personal user
  users.extraUsers.kiba = {
    description = "Kiba Fox";
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    uid = 1000;
  };
}
