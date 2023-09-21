{ config, pkgs, ... }: {
    home.packages = with pkgs; [ 
      firefox
      spotify
      signal-desktop
      vscode
      #vscodium
      yubioath-flutter
      git
    ];

    home.username = "ruben";
    home.homeDirectory = "/home/ruben";

    programs.home-manager.enable = true;

    #manual.manpages.enable = false;

    programs.bash.enable = true;
    programs.git = {
      enable = true;
      userName  = "Ruben Hoenle";
      userEmail = "git@hoenle.xyz";
    };

    home.stateVersion = "23.05";

    # flakes
    #nix = {
    #  package = pkgs.nix;
    #  settings.experimental-features = [ "nix-command" "flakes" ];
    #};
  }

