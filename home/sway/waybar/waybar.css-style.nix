{ ... }:
let
  font-size = "13px";
  background-color = "#180545";
  text-color = "#ccc";
  blinking = {
    color = "#000";
    background-color.warning = "#777";
    background-color.critical = "#FF0000";
  };
in
{
  programs.waybar.style = ''
    /* -----------------------------------------------------------------------------
     * Keyframes
     * -------------------------------------------------------------------------- */

    @keyframes blink-warning {
        70% {
            color: ${blinking.color};
        }

        to {
            color: ${blinking.color};
            background-color: ${blinking.background-color.warning};
        }
    }

    @keyframes blink-critical {
        70% {
            color: ${blinking.color};
        }

        to {
            color: ${blinking.color};
            background-color: ${blinking.background-color.critical};
        }
    }

    /* -----------------------------------------------------------------------------
     * Base styles
     * -------------------------------------------------------------------------- */

    /* Reset all styles */
    * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
        font-family: "JetBrainsMono Nerd Font", "Roboto Mono", sans-serif;
    }

    /* The whole bar */
    window#waybar {
        color: #777;
        background: transparent;
        font-size: ${font-size};
    }

    /* Each module */
    #custom-nixstore,
    #custom-vpn,
    #custom-spacestatus,
    #custom-clipboard,
    #custom-dnd,
    #bluetooth,
    #battery,
    #clock,
    #cpu,
    #memory,
    #mode,
    #network,
    #wireplumber,
    #pulseaudio,
    #temperature,
    #backlight,
    #language,
    #custom-playerctl,
    #tray {
        padding-left: 10px;
        padding-right: 10px;
    }

    /* Joined modules */
    #custom-nixstore,
    #custom-vpn,
    #custom-spacestatus,
    #custom-dnd,
    #bluetooth,
    #battery,
    #clock,
    #cpu,
    #memory,
    #mode,
    #network,
    #wireplumber,
    #pulseaudio,
    #temperature,
    #backlight,
    #language,
    #custom-playerctl {
        padding: 0 10px;
        margin: 6px 0px;
        color: ${text-color};
        /* font-weight: bold; */
        background-color: ${background-color};
    }

    /* left side of segment */
    #custom-nixstore,
    #language,
    #cpu,
    #network,
    #mode,
    #clock {
        margin-left: 3px;
        padding-left: 13px;
        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px;
    }

    /* right side of segment */
    #custom-nixstore,
    #language,
    #backlight,
    #clock,
    #mode,
    #battery {
        margin-right: 3px;
        padding-right: 13px;
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
    }

    /* -----------------------------------------------------------------------------
     * Module styles
     * -------------------------------------------------------------------------- */

    #battery {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #battery.warning.discharging {
        animation-name: blink-warning;
        animation-duration: 3s;
    }

    #battery.critical.discharging {
        animation-name: blink-critical;
        animation-duration: 2s;
    }

    #clock {
        font-weight: bold;
    }

    #memory {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #workspaces button {
        padding: 0 10px;
        margin: 6px 3px;
        border-radius: 4px;
        border: 1px solid ${background-color};
        background-color: ${background-color};
        color: ${text-color};
    }

    #workspaces button.focused {
        border-color: #444;
    }'';
}
