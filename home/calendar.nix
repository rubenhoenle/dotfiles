{ pkgs, osConfig, ... }:
{
  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;
  programs.khal.enable = true;

  accounts.calendar = {
    basePath = "/home/ruben/.calendars";

    accounts = {
      nextcloud = {
        khal = {
          enable = true;
          color = "light green";
          type = "discover";
        };

        local = {
          type = "filesystem";
          fileExt = ".ics";
        };

        remote = {
          type = "caldav";
          url = "https://cloud.hoenle.xyz/remote.php/dav";
          userName = "ruben";
          passwordCommand = [ "${pkgs.coreutils}/bin/cat" osConfig.age.secrets.nextcloudCalendarToken.path ];
        };

        vdirsyncer = {
          enable = true;
          metadata = [ "color" ];
          collections = [ "persnlich" ];
          conflictResolution = "remote wins";
        };
      };
    };
  };
}
