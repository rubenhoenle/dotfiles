{ nixos-hardware }: [
  {
    name = "tantive4";
    nixosModules = [
      ./hardware/thinkpad-l560.nix
      {
        ruben.network.hostname = "tantive4";
      }
    ];
  }
  {
    name = "deathstar";
    nixosModules = [
      ./hardware/thinkpad-l590.nix
      {
        ruben.network.hostname = "deathstar";

        # Setup keyfile
        boot.initrd.secrets = {
          "/crypto_keyfile.bin" = null;
        };

        # Enable swap on luks
        boot.initrd.luks.devices."luks-1479230d-a028-45d4-a769-191948406264".device = "/dev/disk/by-uuid/1479230d-a028-45d4-a769-191948406264";
        boot.initrd.luks.devices."luks-1479230d-a028-45d4-a769-191948406264".keyFile = "/crypto_keyfile.bin";
      }
    ];
  }
  {
    name = "millenium-falcon";
    nixosModules = [
      ./hardware/thinkpad-t14s.nix
      {
        ruben.network.hostname = "millenium-falcon";
        ruben.backup.enable = true;
        #ruben.unbound.enable = true;
        ruben.wireguard.enable = true;

        # Setup keyfile
        #boot.initrd.secrets = {
        #  "/crypto_keyfile.bin" = null;
        #};

        # Enable swap on luks
        #boot.initrd.luks.devices."luks-6d3659bf-9d20-42ad-9fe5-43395cdb683f".device = "/dev/disk/by-uuid/6d3659bf-9d20-42ad-9fe5-43395cdb683f";
        #boot.initrd.luks.devices."luks-6d3659bf-9d20-42ad-9fe5-43395cdb683f".keyFile = "/crypto_keyfile.bin";

        swapDevices = [{
          device = "/var/lib/swapfile";
          size = 16 * 1024;
        }];
      }
    ];
  }
]
