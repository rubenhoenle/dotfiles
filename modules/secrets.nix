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
  age.secrets.paperlessPassword = {
    file = ../secrets/paperless-password.age;
    owner = "ruben";
    group = "users";
  };
}
