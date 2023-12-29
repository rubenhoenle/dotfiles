{
  dconf.settings =
    let
      wallpaper = {
        # to get the hash when adding a new wallpaper, just use 'sha256="";', do a rebuild an use the hash from the error message
        macos = {
          explosion = builtins.fetchurl {
            url = "https://9to5mac.com/wp-content/uploads/sites/6/2016/11/color-burst-2.jpg";
            sha256 = "1hwm8s8izxmvc8pnmqjajnh309in473c71xhg34dzigyd45qrizr";
          };
          purple = builtins.fetchurl {
            url = "https://4kwallpapers.com/images/wallpapers/macos-monterey-wwdc-21-stock-dark-mode-5k-5120x2880-5585.jpg";
            sha256 = "01vfimsvbsg2prm77ziispqmd7l7dkslxb043ajwhi6vajja7mq3";
          };
        };

        xmas = {
          grogu = builtins.fetchurl {
            url = "https://wallpapers.com/images/hd/star-wars-christmas-2dvg08e460wzr8ht.jpg";
            sha256 = "1g2nviayqi5jzg0f57hh4392wpq7vcksq74dybkmrx0sj0hhn9nl";
          };
        };

        porsche = builtins.fetchurl {
          url = "https://images7.alphacoders.com/975/975238.jpg";
          sha256 = "1k45qkyxwarp18d069pswg3f41y0ncmyskm2fpmdsyfrgrgk2cva";
        };
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
      "org/gnome/terminal/legacy" = {
        theme-variant = "dark";
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
        picture-uri = "file://${wallpaper.macos.purple}";
        picture-uri-dark = "file://${wallpaper.macos.purple}";
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


