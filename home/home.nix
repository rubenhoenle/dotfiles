{ pkgs, pkgs-unstable, osConfig, ... }:
let
  user = "ruben";
in
{
  home.packages = with pkgs; [
    # desktop applications
    yubioath-flutter
    yubikey-manager # yubikey manager cli
    yubikey-manager-qt # yubikey manager gui
    libreoffice
    pinta
    shutter
    vlc
    inkscape

    gnome.gnome-calculator
    evince # gnome pdf reader
    gnome.eog # gnome image viewer

    openvpn

    tldr
    zip
    unzip

    curl
    dnsutils

    insomnia

    screenfetch
    neofetch
    cmatrix
    nix-zsh-completions
    xclip
    btop
    glow

    ripgrep
    pkgs-unstable.protonmail-desktop
    pkgs-unstable.container-structure-test
    chromium

    pkgs.spotify
  ] ++ (if osConfig.ruben.host.work then [
    # work applications
    pkgs.teams-for-linux
    pkgs.postman
    pkgs.dbeaver-bin
    pkgs.jetbrains.idea-community-bin
    pkgs.thunderbird
  ] else [
    # private applications
    pkgs.cryptomator
    pkgs.signal-desktop
    pkgs.element-desktop

    # games
    pkgs.prismlauncher
    pkgs.openarena
  ]);

  home.stateVersion = osConfig.system.stateVersion;

  home.username = user;
  home.homeDirectory = "/home/${user}";

  programs.home-manager.enable = true;
  programs.bash.enable = true;

  # make neovim the default editor
  programs.neovim.defaultEditor = true;

  xdg.enable = true;

  imports = [
    ./calendar.nix
    ./clonerer.nix
    ./default-applications.nix
    ./firefox.nix
    ./git.nix
    ./neovim/neovim.nix
    ./ssh.nix
    ./sway/default.nix
    ./vim.nix
    ./vscode.nix
    ./zsh.nix
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
      "file:///home/${user}/Developer Developer"
      "file:///home/${user}/Documents/paperless_open paperless_open"
      "file:///home/${user}/nobackup nobackup"
      "file:///home/${user}/Downloads"
      "file:///home/${user}/Documents"
      "file:///home/${user}/NAS"
      "file:///home/${user}/Pictures"
      "file:///home/${user}/Videos Videos"
      "file:///home/${user}/Music Music"
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

