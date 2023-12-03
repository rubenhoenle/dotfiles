{ config, lib, ... }:
with lib;
let
  cfg = config.ruben.wireguard;
in
{
  options.ruben.wireguard = {
    enable = mkEnableOption "wireguard VPN";
  };

  config = mkIf (cfg.enable)
    {
      networking.firewall = {
        allowedUDPPorts = [ 51820 ];
      };

      environment.etc = {
        "resolv.conf".text = "nameserver 192.168.178.1\nnameserver 9.9.9.9";
      };

      networking.wireguard.interfaces = {
        # "wg0" is the network interface name. You can name the interface arbitrarily.
        wg0 = {
          # Determines the IP address and subnet of the client's end of the tunnel interface.
          ips = [ "192.168.178.201/24" ];
          listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

          privateKeyFile = config.age.secrets.wireguardPrivateKey.path;

          peers = [
            # For a client configuration, one peer entry for the server will suffice.
            {
              # Public key of the server (not a file path).
              publicKey = "Y+05DwKKlt5cQe0y1eXfWQuslfOghgr0TQXC/0X/3HY=";

              presharedKeyFile = config.age.secrets.wireguardPresharedKey.path;

              # Forward all the traffic via VPN.
              allowedIPs = [
                #"0.0.0.0/0" 
                "192.168.178.0/24"
              ];
              # Or forward only particular subnets
              #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

              # Set this to the server IP and port.
              endpoint = "rubaem.duckdns.org:57444";
              # ToDo: route to endpoint not automatically configured #
              # https://wiki.archlinux.org/index.php/WireGuard#Loop_routing 
              # https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

              # Send keepalives every 25 seconds. Important to keep NAT tables alive.
              persistentKeepalive = 25;
            }
          ];
        };
      };
    };
}
