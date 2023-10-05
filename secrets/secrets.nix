let
  tantive4 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgK7/NOff+EL/e2MQ8e2ELoU2nFMsytxqpDyKaQhE7N";
in
{
  "restic-password.age".publicKeys = [ tantive4 ];
  "backblaze-b2-restic-s3-secrets.age".publicKeys = [ tantive4 ];
}
