{
  nix = {
    # nix garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # flakes
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

}
