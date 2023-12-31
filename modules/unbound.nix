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
      services.unbound.enable = true;
    };
}
