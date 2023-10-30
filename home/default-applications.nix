{ config, pkgs, ... }: {

  #home-manager.users.ruben.
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # set firefox as default browser
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";

      # pdf
      "application/pdf" = "org.gnome.Evince.desktop";

      # images
      "image/*" = "org.gnome.eog.desktop";
    };
  };

  #environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/qutebrowser";
}

