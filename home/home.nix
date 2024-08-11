{ pkgs, pkgs-unstable, osConfig, ... }:
let
  user = "ruben";
  idea = pkgs.writeShellScriptBin "idea" ''
    ${pkgs.jetbrains.idea-community-bin}/bin/idea-community "$1" >/dev/null 2>&1 & 
  '';
in
{
  home.packages = with pkgs; [
    # desktop applications
    yubikey-manager # yubikey manager cli
    libreoffice
    pinta
    shutter
    vlc
    inkscape

    gnome.gnome-calculator
    evince # gnome pdf reader
    gnome.eog # gnome image viewer

    tldr
    zip
    unzip

    curl
    dnsutils

    bruno

    cmatrix
    nix-zsh-completions
    xclip
    btop
    glow

    ripgrep
    pkgs-unstable.protonmail-desktop
    pkgs-unstable.container-structure-test
    chromium

    podman-compose

    pkgs.spotify
    pkgs.signal-desktop
    pkgs.element-desktop

    pkgs.jetbrains.idea-community-bin

    idea
  ] ++ (if osConfig.ruben.host.work then [
    # work applications
    pkgs.teams-for-linux
    pkgs.postman
    pkgs.dbeaver-bin
    pkgs.thunderbird
  ] else [
    # private applications
    pkgs.cryptomator
    pkgs.openvpn

    # games
    pkgs.prismlauncher
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
    gtk3.bookmarks =
      let
        prefix = "file:///home/${user}";
      in
      [
        "${prefix}/Developer Developer"
        "${prefix}/Documents/paperless_open paperless_open"
        "${prefix}/nobackup nobackup"
        "${prefix}/Downloads"
        "${prefix}/Documents"
        "${prefix}/Pictures"
        "${prefix}/Videos Videos"
        "${prefix}/Music Music"
        "${prefix}/.local/share/Cryptomator/mnt/Archive-Vault"
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

