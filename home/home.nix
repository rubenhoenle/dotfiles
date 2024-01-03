{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # desktop applications
    spotify
    signal-desktop
    yubioath-flutter
    gnome.gnome-terminal
    libreoffice
    cryptomator
    syncthing
    pinta
    shutter
    vlc
    inkscape

    curl
    dnsutils

    # development
    vscode
    insomnia

    restic
    screenfetch
    neofetch
    asciiquarium
    cmatrix
    nix-zsh-completions
    xclip
    htop
    glow

    # games
    #THIS IS CAUSING THE REBUILDS: prismlauncher
    prismlauncher-qt5
    openarena
  ];

  home.stateVersion = "23.11";

  home.username = "ruben";
  home.homeDirectory = "/home/ruben";

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.chromium.enable = true;

  # make neovim the default editor
  programs.neovim.defaultEditor = true;

  xdg.enable = true;

  imports = [
    ./firefox.nix
    ./git.nix
    ./vim.nix
    ./zsh.nix

    ./neovim/neovim.nix

    ./default-applications.nix

    # gnome configurations
    ./dconf.nix
  ];


}

