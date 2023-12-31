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
    };
  };
}
