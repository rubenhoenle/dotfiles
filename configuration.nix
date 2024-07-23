{ pkgs, agenix, ... }:
{
  security.polkit.enable = true;

  # for yubico authenticator
  services.pcscd.enable = true;

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services.devmon.enable = true;
  services.udisks2.enable = true;

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    curl
    zsh
    agenix
  ];

}
