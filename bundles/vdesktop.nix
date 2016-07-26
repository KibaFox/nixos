# Virtual Box Desktop Bundle

{ ... }:

{
  imports = [
    ../common.nix
    ../roles/workstation.nix
    ../roles/graphical_workstation.nix
    ../roles/midori_browser.nix
    ../roles/canto_rss_user.nix
    ../roles/gocoder.nix
    ../roles/elixir_coder.nix
    ../roles/pia.nix
  ];
}
