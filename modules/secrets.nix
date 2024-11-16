{ lib, config, ... }:
{
  age = {
    identityPaths = [
      "/home/ruben/.ssh/id_ed25519"
      "/home/ruben/.ssh/agenix/millenium-falcon/id_ed25519"
    ];
    secrets = {
      resticPassword = lib.mkIf (config.ruben.backup.enable) {
        file = ../secrets/restic-password.age;
        owner = "ruben";
        group = "users";
      };
      backblazeB2ResticS3EnvironmentSecrets = lib.mkIf (config.ruben.backup.enable) {
        file = ../secrets/backblaze-b2-restic-s3-secrets.age;
        owner = "ruben";
        group = "users";
      };
      wireguardPrivateKey = lib.mkIf (config.ruben.wireguard.enable) {
        file = ../secrets/wireguard-private-key.age;
        owner = "ruben";
        group = "users";
      };
      wireguardPresharedKey = lib.mkIf (config.ruben.wireguard.enable) {
        file = ../secrets/wireguard-preshared-key.age;
        owner = "ruben";
        group = "users";
      };
    };
  };
}
