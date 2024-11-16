let
  deathstar = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSGQkg+lmetJAVsd0Ojy76ehuoc2aJuIP03f08Ny0lQ";
  millenium-falcon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFQ1M3a2Vm5ihxBOayp6QznV0WwIVDTKyeFTenm/rxS1";
in
{
  "restic-password.age".publicKeys = [ deathstar ];
  "backblaze-b2-restic-s3-secrets.age".publicKeys = [ deathstar ];
  "wireguard-private-key.age".publicKeys = [ millenium-falcon deathstar ];
  "wireguard-preshared-key.age".publicKeys = [ millenium-falcon deathstar ];
}
