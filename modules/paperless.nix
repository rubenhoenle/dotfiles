{ config, pkgs, inputs, agenix, ... }:
let
  pwFile = pkgs.writeText "paperlessPw" "admin";
in
{
  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 58080;
    passwordFile = pwFile;
    user = "ruben";
    dataDir = "/home/ruben/services/nix/paperless/data";
    mediaDir = "/home/ruben/services/nix/paperless/media";
    extraConfig.PAPERLESS_OCR_LANGUAGE = "deu+eng";
    extraConfig.PAPERLESS_ADMIN_USER = "ruben";
  };
  systemd.services.paperless-scheduler.after = [ "var-lib-paperless.mount" ];
  systemd.services.paperless-consumer.after = [ "var-lib-paperless.mount" ];
  systemd.services.paperless-web.after = [ "var-lib-paperless.mount" ];
}
