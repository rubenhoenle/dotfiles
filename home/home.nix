{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    spotify
    signal-desktop
    vscode
    yubioath-flutter
    restic
    screenfetch
    asciiquarium
    cmatrix
    nix-zsh-completions
    #adoptopenjdk-bin
    #gtk3
    gnome.gnome-terminal
    libreoffice
    vlc
    xclip
    cryptomator

    # python
    python311
    python311Packages.pandas
    python311Packages.matplotlib

    # games
    #minecraft-launcher
    prismlauncher
    openarena
  ];

  home.stateVersion = "23.05";

  home.username = "ruben";
  home.homeDirectory = "/home/ruben";

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.chromium.enable = true;

  # make vim the default editor
  programs.vim.defaultEditor = true;

  imports = [
    ./git.nix
    ./vim.nix
    ./zsh.nix

    ./neovim/neovim.nix

    # gnome configurations
    ./dconf.nix
  ];
}

