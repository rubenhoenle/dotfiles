# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/1462e22d-fcc9-497e-b364-9c5aa1ca1e7b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-351f1209-4aa9-46a1-beb0-2d1688c20653".device = "/dev/disk/by-uuid/351f1209-4aa9-46a1-beb0-2d1688c20653";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/92C7-451E";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/182e463a-b8ed-4b18-a1fc-5752f61de2e1"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wwp0s20f0u9.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}