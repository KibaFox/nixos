# Virtual Box Desktop Bundle

{ ... }:

{
  imports = [
    ../common.nix
    ../roles/workstation.nix
    ../roles/graphical_workstation.nix
    ../roles/canto_rss_user.nix
    ../roles/gocoder.nix
    ../roles/pia.nix
  ];
}
