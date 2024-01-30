{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      foo = {
        layer = "top";

        /* height = "30"; */
        /* position = "top"; */

        modules-left = [ "clock" "custom/nixstore" "sway/workspaces" ];
        modules-center = [ "sway/mode" ];
        modules-right = [
          # connecting
          "network"
          "bluetooth"
          # media
          "idle_inhibitor"
          "wireplumber"
          "backlight"
          # informational
          "cpu"
          "temperature"
          "memory"
          "battery"
        ];

        # modules
        "custom/nixstore" = {
          exec = "${pkgs.coreutils}/bin/du -sh /nix/store | ${pkgs.gnused}/bin/sed 's/\\([0-9]\\+[A-Z]\\+\\).*/\\1/'";
          interval = 300;
          format = "  {}";
          tooltip = false;
        };
        battery = {
          interval = 30;
          states = {
            warning = 30;
            critical = 15;
          };
          format-charging = "BAT: {capacity}%";
          format = "BAT: {capacity}%";
          tooltip = true;
        };
        clock = {
          interval = 60;
          format = "{:%A %d.%m.%Y %H:%M}";
          tooltip = true;
          tooltip-format = "{:%d.%m.%Y}\n<tt>{calendar}</tt>";
          calendar = {
            weeks-pos = "right";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
        cpu = {
          format = "CPU: {usage}%";
          tooltip = false;
        };
        temperature = {
          interval = 5;
          format = "{temperatureC}°C";
          tooltip = false;
        };
        memory = {
          format = "MEM: {percentage}%";
          tooltip = false;
        };
        network = {
          format = "NET: none";
          format-wifi = "NET: {essid}";
          format-ethernet = "NET: wired";
          tooltip-format = "{icon} {ifname} = {ipaddr}";
          tooltip-format-ethernet = "{icon} {ifname} = {ipaddr}";
          tooltip-format-wifi = "{icon} {ifname} ({essid}) = {ipaddr}";
          tooltip-format-disconnected = "{icon} disconnected";
          tooltip-format-disabled = "{icon} disabled";
          on-click = "${pkgs.alacritty}/bin/alacritty --class floating_shell -o window.dimensions.columns=82 -o window.dimensions.lines=25 -e ${pkgs.networkmanager}/bin/nmtui connect";
        };
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
          tooltip = false;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "PERFORMANCE";
            deactivated = "POWERSAVER";
          };
          tooltip = true;
          tooltip-format-activated = "power-saving disabled";
          tooltip-format-deactivated = "power-saving enabled";
        };
        backlight = {
          tooltip = false;
          format = "BRI: {percent}%";
        };
        wireplumber = {
          format = "VOL: {volume}%";
        };
        bluetooth = {
          format = "BLUE: on";
          format-disabled = "BLUE: off";
          on-click = "${pkgs.alacritty}/bin/alacritty --class floating_shell -o window.dimensions.columns=82 -o window.dimensions.lines=25 -e ${pkgs.bluetuith}/bin/bluetuith";
          on-click-right = "rfkill toggle bluetooth";
          tooltip-format = "{}";
        };
      };
    };
  };

  imports = [ ./waybar.css-style.nix ];
}
