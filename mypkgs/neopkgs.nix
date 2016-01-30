# Neopkgs - A more recent version of nixpkgs from GitHub
{ pkgs }:

import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "8f793ce6bb050252e92a987cc3c5bd48d5423a42";
    sha256 = "0fydxirp79s4svr2gadp3hsx2vrank904n8c5kprqh3jrzid90cg";
}) {}
