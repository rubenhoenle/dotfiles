{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    #google-fonts
    corefonts
    atkinson-hyperlegible # hackwerk logo font
    #nerdfonts
  ];
}
