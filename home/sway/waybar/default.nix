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

        modules-left = [ "custom/nixstore" "sway/workspaces" ];
        modules-center = [ "sway/mode" ];
        modules-right = [
          "sway/language"
          # connecting
          "network"
          "bluetooth"
          # media
          "custom/playerctl"
          "idle_inhibitor"
          "custom/dnd"
          "pulseaudio"
          "backlight"
          # informational
          "cpu"
          "temperature"
          "memory"
          "battery"
          # system
          "clock"
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
          format-charging = "󰂄 {capacity}%";
          format = "{icon} {capacity}%";
          format-icons = ["󱃍" "󰁺" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          tooltip = true;
        };
        clock = {
          interval = 60;
          format = "{:%H:%M}";
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
          interval = 10;
          format = "󰘚";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = true;
        };
        memory = {
          interval = 10;
          format = "󰍛";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = true;
        };
        network = {
          interval = 5;
          format-wifi = " ";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
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
            activated = "󰒳";
            deactivated = "󰒲";
          };
          tooltip = true;
          tooltip-format-activated = "power-saving disabled";
          tooltip-format-deactivated = "power-saving enabled";
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
          on-scroll-up = "${pkgs.swayfx}/bin/swaymsg exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
          on-scroll-down = "${pkgs.swayfx}/bin/swaymsg exec ${pkgs.brightnessctl}/bin/brightnessctl set -5%";
        };
        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}%{format_source}";
          format-muted = "󰖁 {format_source}";
          format-source = "";
          format-source-muted = " 󰍭";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          tooltip-format = "{icon}  {volume}% {format_source}";
          on-click = "${pkgs.swayfx}/bin/swaymsg exec \"${pkgs.alacritty}/bin/alacritty --class floating_shell -o window.dimensions.columns=82 -o window.dimensions.lines=25 -e ${pkgs.pulsemixer}/bin/pulsemixer\"";
          on-click-middle = "${pkgs.swayfx}/bin/swaymsg exec exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-scroll-up = "${pkgs.swayfx}/bin/swaymsg exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          on-scroll-down = "${pkgs.swayfx}/bin/swaymsg exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        };
        temperature = {
          critical-threshold = 90;
          interval = 5;
          format = "{icon}";
          tooltip-format = "{temperatureC}°C";
          format-icons = ["" "" ""];
          tooltip = true;
          on-click = "${pkgs.swayfx}/bin/swaymsg exec \"${pkgs.alacritty}/bin/alacritty --class floating_shell -o window.dimensions.columns=82 -o window.dimensions.lines=25 -e watch ${pkgs.lm_sensors}/bin/sensors\"";
        };
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          on-click = "${pkgs.alacritty}/bin/alacritty --class floating_shell -o window.dimensions.columns=82 -o window.dimensions.lines=25 -e ${pkgs.bluetuith}/bin/bluetuith";
          on-click-right = "rfkill toggle bluetooth";
          tooltip-format = "{}";
        };
        "sway/language" = {
          format = " {}";
          min-length = 5;
          tooltip = false;
          on-click = "${pkgs.swayfx}/bin/swaymsg input $(${pkgs.swayfx}/bin/swaymsg -t get_inputs --raw | ${pkgs.jq}/bin/jq '[.[] | select(.type == \"keyboard\")][0] | .identifier') xkb_switch_layout next";
        };
        "custom/playerctl" = {
          interval = "once";
          tooltip = true;
          return-type = "json";
          format = "{icon}";
          format-icons = {
            Playing = "󰏦";
            Paused = "󰐍";
          };
          exec = "${pkgs.playerctl}/bin/playerctl metadata --format '{\"alt\": \"{{status}}\", \"tooltip\": \"{{playerName}}: {{markup_escape(title)}} - {{markup_escape(artist)}}\" }'";
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause; ${pkgs.procps}/bin/pkill -RTMIN+5 waybar";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next; ${pkgs.procps}/bin/pkill -RTMIN+5 waybar";
          on-scroll-up = "${pkgs.playerctl}/bin/playerctl position 10+; ${pkgs.procps}/bin/pkill -RTMIN+5 waybar";
          on-scroll-down = "${pkgs.playerctl}/bin/playerctl position 10-; ${pkgs.procps}/bin/pkill -RTMIN+5 waybar";
          signal = 5;
        };
        "custom/dnd" = {
          interval = "once";
          return-type = "json";
          format = "{}{icon}";
          format-icons = {
            default = "󰚢";
            dnd = "󰚣";
          };
          on-click = "${pkgs.mako}/bin/makoctl mode | ${pkgs.gnugrep}/bin/grep 'do-not-disturb' && ${pkgs.mako}/bin/makoctl mode -r do-not-disturb || ${pkgs.mako}/bin/makoctl mode -a do-not-disturb; ${pkgs.procps}/bin/pkill -RTMIN+11 waybar";
          on-click-right = "${pkgs.mako}/bin/makoctl restore";
          exec = "printf '{\"alt\":\"%s\",\"tooltip\":\"mode = %s\"}' $(${pkgs.mako}/bin/makoctl mode | ${pkgs.gnugrep}/bin/grep -q 'do-not-disturb' && echo dnd || echo default) $(${pkgs.mako}/bin/makoctl mode | ${pkgs.coreutils}/bin/tail -1)";
          signal = 11;
        };
      };
    };
    style = ./bar.css;
  };
}
