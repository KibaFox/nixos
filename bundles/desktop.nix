# Desktop Bundle

{ ... }:

{
  imports = [
    ./vdesktop.nix
    ../roles/redshift.nix
    ../roles/wine_user.nix
    ../roles/gamer.nix
  ];
}
