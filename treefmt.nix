{
  projectRootFile = "flake.nix";
  settings.global.excludes = [ "*.age" ];

  programs = {
    nixpkgs-fmt.enable = true;
    shellcheck.enable = true;
    stylua.enable = true;
  };
}
