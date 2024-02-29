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
        "192.168.178.1" = [ "fritz.box" ];
        "192.168.178.2" = [ "synology" "synology.fritz.box" ];
        "192.168.178.5" = [
          "mandalore"
          "paperless.local"
          "tandoor.local"
          "mandalore.local"
          "wiki.local"
          "whoami.local"
          "pad.local"
          "pad.hoenle.xyz"
          "pad.home.hoenle.xyz"
          "recipes.hoenle.xyz"
          "recipes.home.hoenle.xyz"
          "paperless.hoenle.xyz"
          "paperless.home.hoenle.xyz"
        ];
        "192.168.178.20" = [ "printer01" "printer01.fritz.box" ];
      };
    };
  };
}
