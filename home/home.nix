{ pkgs, osConfig, ... }:
let
  user = "ruben";
  idea = pkgs.writeShellScriptBin "idea" ''
    ${pkgs.jetbrains.idea-community-bin}/bin/idea-community "$1" >/dev/null 2>&1 & 
  '';
  weather = pkgs.writeShellScriptBin "weather" ''
    ${pkgs.curl}/bin/curl wttr.in
  '';
  fs-mount = pkgs.writeShellScriptBin "fs-mount" ''
    ${pkgs.sshfs}/bin/sshfs -oport=41524 fileserver@192.168.178.5:/home/fileserver /home/ruben/fileserver
  '';
  fs-unmount = pkgs.writeShellScriptBin "fs-unmount" ''
    fusermount -u /home/ruben/fileserver
  '';
  tunnel = pkgs.writeShellScriptBin "tunnel" ''
    ssh mandalore -L 4000:localhost:8085 -N
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

    gnome-calculator
    evince # gnome pdf reader
    eog # gnome image viewer

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

    podman-compose

    pkgs.spotify
    pkgs.signal-desktop
    pkgs.element-desktop

    # custom scripts
    idea
    weather
  ] ++ (if osConfig.ruben.host.work then [
    # work applications
    pkgs.teams-for-linux
    pkgs.postman
    pkgs.dbeaver-bin
    pkgs.thunderbird

    pkgs.jetbrains.idea-community-bin
    pkgs.eclipses.eclipse-java
  ] else [
    # private applications
    pkgs.cryptomator
    pkgs.openvpn
    (pkgs.inkscape-with-extensions.override {
      inkscapeExtensions = with pkgs.inkscape-extensions; [
        silhouette
      ];
    })

    # games
    pkgs.prismlauncher

    # fileserver
    fs-mount
    fs-unmount
    tunnel
  ]);

  home.stateVersion = osConfig.system.stateVersion;

  home.username = user;
  home.homeDirectory = "/home/${user}";

  programs.home-manager.enable = true;

  xdg.enable = true;

  imports = [
    ./clonerer.nix
    ./default-applications.nix
    ./firefox.nix
    ./git.nix
    ./neovim/neovim.nix
    ./selecterer.nix
    ./shell.nix
    ./ssh.nix
    ./sway/default.nix
    ./vscode.nix
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
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

