{ pkgs, ... }: {

  imports = [
    ./backup.nix
    ./firmware.nix
    ./network.nix
    ./printing.nix
    ./unbound.nix
    ./wireguard.nix
    ./secrets.nix
  ];

}
