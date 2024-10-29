{ lib, config, inputs, ... }:
let
  secretspath = builtins.toString inputs.secrets;
in
{
  age = {
    identityPaths = [ "/home/ruben/.ssh/id_ed25519" ];
    secrets = {
      resticPassword = lib.mkIf (config.ruben.backup.enable) {
        file = "${secretspath}/restic-password.age";
        owner = "ruben";
        group = "users";
      };
      backblazeB2ResticS3EnvironmentSecrets = lib.mkIf (config.ruben.backup.enable) {
        file = "${secretspath}/backblaze-b2-restic-s3-secrets.age";
        owner = "ruben";
        group = "users";
      };
      wireguardPrivateKey = lib.mkIf (config.ruben.wireguard.enable) {
        file = "${secretspath}/wireguard-private-key.age";
        owner = "ruben";
        group = "users";
      };
      wireguardPresharedKey = lib.mkIf (config.ruben.wireguard.enable) {
        file = "${secretspath}/wireguard-preshared-key.age";
        owner = "ruben";
        group = "users";
      };
    };
  };
}
