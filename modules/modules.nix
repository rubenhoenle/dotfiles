{ pkgs, ... }: {

  imports = [
    ./backup.nix
    ./firmware.nix
    ./network.nix
    ./printing.nix
  ];

}