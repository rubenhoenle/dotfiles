{ nixos-hardware, disko }: [
  {
    name = "deathstar";
    nixosModules = [
      disko.nixosModules.disko
      #(import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      ./hardware/thinkpad-l590.nix
      {
        ruben.network.hostname = "deathstar";

        ruben.backup.enable = true;

        console.keyMap = "de";
        ruben.wireguard.enable = true;

        system.stateVersion = "24.05";
      }
    ];
  }
  {
    name = "millenium-falcon";
    nixosModules = [
      ./hardware/thinkpad-t14.nix
      {
        ruben.network.hostname = "millenium-falcon";
        #ruben.backup.enable = true;
        ruben.wireguard.enable = true;

        console.keyMap = "us";

        swapDevices = [{
          device = "/var/lib/swapfile";
          size = 16 * 1024;
        }];

        system.stateVersion = "24.05";
      }
    ];
  }
]
