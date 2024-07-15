{ pkgs, osConfig, ... }:
let
  common = {
    khal = {
      enable = true;
      type = "discover";
    };
    local = {
      type = "filesystem";
      fileExt = ".ics";
    };
  };
in
{
  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;
  programs.khal.enable = true;

  accounts.calendar = {
    basePath = "/home/ruben/.calendars";

    accounts = {
      nextcloud = {
        khal = common.khal;
        local = common.local;

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
      mailbox_org = {
        khal = common.khal;
        local = common.local;

        remote = {
          type = "caldav";
          url = "https://dav.mailbox.org";
          userName = "deathstar@mailbox.org";
          passwordCommand = [ "${pkgs.coreutils}/bin/cat" osConfig.age.secrets.mailboxOrgPassword.path ];
        };

        vdirsyncer = {
          enable = true;
          metadata = [ "color" ];
          collections = [ "Y2FsOi8vMC8zMQ" "Y2FsOi8vMC80OA" "Y2FsOi8vMC80Mw" "Y2FsOi8vMC80Ng" "Y2FsOi8vMS8w" ];
          conflictResolution = "remote wins";
        };
      };
    };
  };
}
