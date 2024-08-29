{ config, lib, ... }:
with lib;
let
  cfg = config.ruben.network;
in
{
  options.ruben.network = {
    hostname = mkOption {
      type = types.str;
    };
  };
  config = {
    networking = {
      hostName = cfg.hostname;
      networkmanager.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [ 25565 ];
        allowedUDPPorts = [ 25565 ];
      };
      hosts = {
        "192.168.178.2" = [ "synology" "synology.fritz.box" ];
      };
    };

    networking.networkmanager.ensureProfiles.profiles = {
      "Hack-mas" = {
        connection = {
          id = "Hack-mas";
          type = "wifi";
          autoconnect = true;
          interface-name = "wlp3s0";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "Hack ma's";
        };
        wifi-security = {
          key-mgmt = "wpa-eap";
        };
        "802-1x" = {
          eap = "ttls;";
          identity = "hackmas";
          password = "hackmas";
          phase2-auth = "pap";
          domain-suffix-match = "radius.noc.hack-mas.at";
          ca-cert = "${builtins.fetchurl {
            url = "https://letsencrypt.org/certs/isrgrootx1.pem";
            sha256 = "sha256:1la36n2f31j9s03v847ig6ny9lr875q3g7smnq33dcsmf2i5gd92";
            }}";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };
      };
    };
  };

}
