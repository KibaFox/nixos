# Neopkgs - A more recent version of nixpkgs from GitHub
args@{ ... }:

let
  pkgs = import <nixpkgs> {};
in
import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "be0abb32f6a049fc5713f6b9235f01e4c6a1efcf";
    sha256 = "18vwrxjjbsc03qql37jncr1lp70i1q0a9dbwwlqshcsvscfqa3g1";
}) ( args )
