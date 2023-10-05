{ config, lib, modulesPath, pkgs, specialArgs, options }: {
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
      script = "export var_bat=$(cat /sys/class/power_supply/BAT0/capacity | grep -Po \"\\d+\"); export var_host=$(hostname); test \"$var_bat\" -le 35 && curl -H ta:battery -L -d \"Battery of $var_host is at $var_bat %\" ${ntfyServer}/${ntfyTopic}";
      serviceConfig = {
        User = config.users.users.ruben.name;
      };
      # run every 5 minutes
      startAt = "*:0/5";
    };
  };
}

