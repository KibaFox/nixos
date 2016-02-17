# Neopkgs - A more recent version of nixpkgs from GitHub
args@{ ... }:

let
  pkgs = import <nixpkgs> {};
in
import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "57b3ad896222abe307c5e20f4dfd7245db6bdb4d";
    sha256 = "1n3nrfyjdlprimj1jdx8siml9rrjw0kzwv8r101syfg4dn41qvk1";
}) ( args )
