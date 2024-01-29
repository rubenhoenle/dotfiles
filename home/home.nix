{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # desktop applications
    spotify
    signal-desktop
    yubioath-flutter
    libreoffice
    cryptomator
    syncthing
    pinta
    shutter
    vlc
    inkscape

    # file manager
    gnome.nautilus

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

    ripgrep

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

  # make neovim the default editor
  programs.neovim.defaultEditor = true;

  xdg.enable = true;

  imports = [
    ./firefox.nix
    ./git.nix
    ./vim.nix
    ./zsh.nix
    ./sway/default.nix
    ./neovim/neovim.nix

    ./default-applications.nix
  ];
}

