{ lib, ... }:
{
  imports = [
    ./sway.nix
    ./backup.nix
    ./bluetooth.nix
    ./boot.nix
    ./fingerprint.nix
    ./firmware.nix
    ./fonts.nix
    ./gtk.nix
    ./locales.nix
    ./network.nix
    ./nix.nix
    ./podman.nix
    ./printing.nix
    ./secrets.nix
    ./sound.nix
    ./unbound.nix
    ./users.nix
    ./wireguard.nix
  ];

  options.ruben.git = {
    name = lib.mkOption {
      default = "Ruben Hoenle";
    };
    mail = lib.mkOption {
      default = "git@hoenle.xyz";
    };
  };

  options.ruben.host = {
    work = lib.mkEnableOption "work machine host options";
  };
}
