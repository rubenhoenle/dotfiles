let
  millenium-falcon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSGQkg+lmetJAVsd0Ojy76ehuoc2aJuIP03f08Ny0lQ";
in
{
  "restic-password.age".publicKeys = [ millenium-falcon ];
  "backblaze-b2-restic-s3-secrets.age".publicKeys = [ millenium-falcon ];
  "wireguard-private-key.age".publicKeys = [ millenium-falcon ];
  "wireguard-preshared-key.age".publicKeys = [ millenium-falcon ];
}
