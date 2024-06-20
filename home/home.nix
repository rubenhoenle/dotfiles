{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    # desktop applications
    spotify
    signal-desktop
    yubioath-flutter
    yubikey-manager # yubikey manager cli
    yubikey-manager-qt # yubikey manager gui
    libreoffice
    cryptomator
    syncthing
    pinta
    shutter
    vlc
    inkscape

    element-desktop

    thonny

    # file manager
    gnome.nautilus
    evince # gnome pdf reader
    gnome.eog # gnome image viewer

    tldr
    zip
    unzip

    curl
    dnsutils

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

    pkgs-unstable.protonmail-desktop

    # games
    prismlauncher-qt5
    openarena

    chromium

    teams-for-linux
    eclipses.eclipse-java
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      github.vscode-github-actions
      sonarsource.sonarlint-vscode
    ];
  };


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
    ./ssh.nix
    ./vim.nix
    ./zsh.nix
    ./sway/default.nix
    ./neovim/neovim.nix

    ./default-applications.nix
  ];
}

