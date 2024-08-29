{ nixos-hardware, disko }: [
  {
    name = "nbell-nixos";
    nixosModules = [
      ./hardware/thinkpad-l580.nix
      {
        ruben.network.hostname = "nbell-nixos";
        console.keyMap = "de";

        ruben.git.name = "ruben.hoenle";
        ruben.git.mail = "ruben.hoenle@fntsoftware.com";
        ruben.host.work = true;

        boot.initrd.luks.devices."luks-b98db7bc-7d65-49d9-b771-1eb36ee43027".device = "/dev/disk/by-uuid/b98db7bc-7d65-49d9-b771-1eb36ee43027";

        system.stateVersion = "23.11";
      }
    ];
  }
  {
    name = "deathstar";
    nixosModules = [
      disko.nixosModules.disko
      (import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      ./hardware/thinkpad-l590.nix
      {
        ruben.network.hostname = "deathstar";

        console.keyMap = "de";

        system.stateVersion = "24.05";
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
        ruben.wireguard.enable = true;

        console.keyMap = "us";

        swapDevices = [{
          device = "/var/lib/swapfile";
          size = 16 * 1024;
        }];

        system.stateVersion = "23.11";
      }
    ];
  }
]
