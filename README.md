NixOS Config
============

My personal NixOS configurations.

Installing
----------

Here is how I currently install my NixOS configurations:

    git clone git@github.com:KibaFox/nixos.git ~/lib/nixos
    sudo mv /etc/nixos/configuration.nix /etc/nixos/bak.nix
    sudo ln -s ~/lib/nixos/machines/{name}.nix /etc/nixos/configuration.nix
