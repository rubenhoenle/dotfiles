{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    #google-fonts
    corefonts
    atkinson-hyperlegible # hackwerk logo font
    #nerdfonts

    #garamond-libre # nett hier, aber...? font
  ];
}
