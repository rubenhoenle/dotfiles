{
  projectRootFile = "flake.nix";
  settings.global.excludes = [ "*.age" ];

  programs = {
    nixpkgs-fmt.enable = true;
    prettier = {
      enable = true;
      includes = [
        "*.md"
        "*.yaml"
        "*.yml"
      ];
    };
    shellcheck.enable = true;
    stylua.enable = true;
  };
}
