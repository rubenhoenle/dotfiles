{ lib, config, ... }:
{
  xdg.configFile."mimeapps.list" = lib.mkIf config.xdg.mimeApps.enable { force = true; };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # set firefox as default browser
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      # pdf
      "application/pdf" = "org.gnome.Evince.desktop";

      # images
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
    };
  };

  #environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}";
}

