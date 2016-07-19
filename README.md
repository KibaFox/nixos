NixOS Config
============

My personal NixOS configurations.

Installing
----------

Here is how I currently install my NixOS configurations:

    git clone https://github.com/KibaFox/nixos.git ~/lib/nixos
    git -C ~/lib/nixos remote set-url --push origin git@github.com:KibaFox/nixos.git
    sudo mv /etc/nixos/configuration.nix /etc/nixos/bak.nix
    sudo ln -s ~/lib/nixos/machines/{name}.nix /etc/nixos/configuration.nix
    sudo -i nixos-rebuild switch --upgrade

Be sure to replace {name} with the machine name.
