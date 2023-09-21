{
  dconf.settings =
    let
      background = builtins.fetchurl {
        url = "https://9to5mac.com/wp-content/uploads/sites/6/2016/11/color-burst-2.jpg";
        sha256 = "1hwm8s8izxmvc8pnmqjajnh309in473c71xhg34dzigyd45qrizr";
      };
    in
    {
      # terminal keybindings, not working yet
      "org/gnome/terminal/legacy/keybindings" = {
        paste = "<Primary>V";
        copy = "<Primary>C";
        new-tab = "<Primary>T";
        close-tab = "<Primary>Q";
      };
      # gnome shortcuts
      "org/gnome/desktop/wm/keybindings" = {
        toggle-fullscreen = "F11";
        minimize = "<Super>M";
        show-desktop = "<Super>D";
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = false;
        click-method = "default";
      };
      "org/gnome/desktop/interface" = {
        clock-show-seconds = false;
        clock-show-weekdays = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };

      # define which apps are pinned to the dock 
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop" 
          "org.gnome.Calendar.desktop" 
          "org.gnome.Nautilus.desktop" 
          "org.gnome.Terminal.desktop" 
          "signal-desktop.desktop"
        ];
      };

      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file://${background}";
        picture-uri-dark = "file://${background}";
        primary-color = "#3366ff";
        secondary-color = "#000000";
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:close"; #"appmenu:minimize,maximize,close";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "terminal 1";
        command = "kgx";
        binding = "<Super>Return";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "terminal 2";
        command = "kgx";
        binding = "<Alt><Ctrl>t";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
    };
}


