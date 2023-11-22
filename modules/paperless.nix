{ config, lib, ... }:
with lib;
let
  cfg = config.ruben.paperless;
  paperlessDir = "/home/ruben/services/nix/paperless";
  passwordFile = config.age.secrets.paperlessPassword.path;
in
{
  options.ruben.paperless = {
    enable = mkEnableOption "paperless service";
  };

  config = mkIf (cfg.enable)
    {
      services.paperless = {
        enable = true;
        address = "0.0.0.0";
        port = 58080;
        passwordFile = passwordFile;
        user = "ruben";
        dataDir = "${paperlessDir}/data";
        mediaDir = "${paperlessDir}/media";
        consumptionDir = "${paperlessDir}/input";
        extraConfig = {
          PAPERLESS_OCR_LANGUAGE = "deu+eng";
          PAPERLESS_ADMIN_USER = "ruben";
          PAPERLESS_TASK_WORKERS = 2;
          PAPERLESS_THREADS_PER_WORKER = 4;
        };
      };
      systemd.services.paperless-scheduler.after = [ "var-lib-paperless.mount" ];
      systemd.services.paperless-consumer.after = [ "var-lib-paperless.mount" ];
      systemd.services.paperless-web.after = [ "var-lib-paperless.mount" ];
    };
}
