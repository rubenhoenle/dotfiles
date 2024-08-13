{
  age.identityPaths = [ "/home/ruben/.ssh/id_ed25519" ];
  age.secrets.resticPassword = {
    file = ../secrets/restic-password.age;
    owner = "ruben";
    group = "users";
  };
  age.secrets.backblazeB2ResticS3EnvironmentSecrets = {
    file = ../secrets/backblaze-b2-restic-s3-secrets.age;
    owner = "ruben";
    group = "users";
  };
  age.secrets.wireguardPrivateKey = {
    file = ../secrets/wireguard-private-key.age;
    owner = "ruben";
    group = "users";
  };
  age.secrets.wireguardPresharedKey = {
    file = ../secrets/wireguard-preshared-key.age;
    owner = "ruben";
    group = "users";
  };
  age.secrets.mailboxOrgPassword = {
    file = ../secrets/mailbox-org-password.age;
    owner = "ruben";
    group = "users";
  };
}
