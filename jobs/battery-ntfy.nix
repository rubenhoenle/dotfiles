{ config, lib, modulesPath, pkgs, specialArgs, options }:
with lib;
let
  cfg = config.ruben.battery.notifications;
in
{
  options.ruben.battery.notifications = {
    enable = mkEnableOption "battery notifications";
    percentage = mkOption {
      type = types.int;
      default = 35;
      description = "The battery percentage under which battery notifications should be send.";
    };
  };


  config = mkIf (cfg.enable) {
    systemd.services = {
      battery-notification =
        let
          ntfyServer = "ntfy.hoenle.xyz";
          ntfyTopic = "test";
        in
        {
          path = [
            pkgs.curl
          ];
          script = "export var_bat=$(cat /sys/class/power_supply/BAT0/capacity | grep -Po \"\\d+\"); test \"$var_bat\" -le ${ toString cfg.percentage} && curl -H ta:battery -L -d \"Battery of ${config.ruben.network.hostname} is at $var_bat %\" ${ntfyServer}/${ntfyTopic}";
          serviceConfig = {
            User = config.users.users.ruben.name;
          };
          # run every 5 minutes
          startAt = "*:0/5";
        };
    };
  };
}

