{ pkgs, ... }:
{
  services.rpcbind.enable = true; # needed for NFS
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems."/mnt/lasercutter" = {
    fsType = "nfs";
    device = "10.20.42.50:/Lasercutter";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600" # disconnects after 10 minutes (i.e. 600 seconds)
    ];
  };
}
