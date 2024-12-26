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
      firewall.enable = true;
    };

    networking.networkmanager.ensureProfiles.profiles = {
      "38C3" = {
        connection = {
          id = "38C3";
          type = "wifi";
          autoconnect = true;
          interface-name = "wlp3s0";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "38C3";
        };
        wifi-security = {
          key-mgmt = "wpa-eap";
        };
        "802-1x" = {
          eap = "ttls;";
          identity = "38C3";
          password = "38C3";
          phase2-auth = "pap";
          domain-suffix-match = "radius.c3noc.net";
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
