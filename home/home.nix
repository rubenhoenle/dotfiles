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
    pinta
    shutter
    vlc
    inkscape

    gnome.gnome-calculator

    element-desktop

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
    prismlauncher
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
    userSettings = {
      "terminal.integrated.gpuAcceleration" = "off";
      "workbench.editor.wrapTabs" = true;
    };
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
    ./clonerer.nix
    ./firefox.nix
    ./git.nix
    ./ssh.nix
    ./vim.nix
    ./zsh.nix
    ./sway/default.nix
    ./neovim/neovim.nix

    ./default-applications.nix
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    /* Bookmarks in the sidebar of the GTK file browser */
    gtk3.bookmarks = [
      "file:///home/ruben/Developer Developer"
      "file:///home/ruben/Documents/paperless_open paperless_open"
      "file:///home/ruben/nobackup nobackup"
      "file:///home/ruben/Downloads"
      "file:///home/ruben/Documents"
      "file:///home/ruben/NAS"
      "file:///home/ruben/Pictures"
      "file:///home/ruben/Videos Videos"
      "file:///home/ruben/Music Music"
    ];
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}

