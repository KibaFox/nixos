# Private Internet Access

# Start with:
#   sudo systemctl start openvpn-us-east.service

{ config, pkgs, ... }:

{
  services.openvpn = {
    servers = {
      us-east = {
        config = ''
          client
          dev tun
          proto udp
          remote us-east.privateinternetaccess.com 1194
          resolv-retry infinite
          nobind
          persist-key
          persist-tun
          ca /root/pia-ca.crt
          tls-client
          remote-cert-tls server
          auth-user-pass
          comp-lzo
          verb 1
          reneg-sec 0
          crl-verify /root/pia-crl.pem
          auth-user-pass /root/pia-login.conf
        '';
        autoStart = false;
      };
    };
  };
}
