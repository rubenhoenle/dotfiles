{ config, lib, ... }:
with lib;
let
  cfg = config.ruben.unbound;
in
{
  options.ruben.unbound = {
    enable = mkEnableOption "local unbound service";
  };

  config = mkIf (cfg.enable)
    {
      services.unbound = {
        enable = true;
        resolveLocalQueries = false;
      };
      networking = {
        nameservers = [ "127.0.0.1" "::1" ];
        networkmanager.dns = lib.mkForce "none";
      };
    };
}
