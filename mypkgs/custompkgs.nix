{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
  callPackage = pkgs.lib.callPackageWith(pkgs // pkgs.xlibs // self);
  self = rec {
    # st = callPackage ./pkgs/st { };
  };
in
  self
