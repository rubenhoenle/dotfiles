{ disk ? "/dev/nvme0n1", ... }:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = disk;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                content = {
                  type = "lvm_pv";
                  vg = "vg";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      vg = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "24G";
            content = {
              type = "swap";
              resumeDevice = true; # resume from hiberation from this device
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
