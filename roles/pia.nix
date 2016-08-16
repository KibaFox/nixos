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
          remote us-east.privateinternetaccess.com 1198
          resolv-retry infinite
          nobind
          persist-key
          persist-tun
          cipher aes-128-cbc
          auth sha1
          tls-client
          remote-cert-tls server
          auth-user-pass
          comp-lzo
          verb 1
          reneg-sec 0
          crl-verify /root/crl.rsa.2048.pem
          ca /root/ca.rsa.2048.crt
          disable-occ
          auth-user-pass /root/pia-login.conf
        '';
        autoStart = false;
        up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
        down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
      };
    };
  };
}
