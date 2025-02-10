{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, agenix, treefmt-nix, nixos-hardware, disko, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;

      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatter = treefmtEval.config.build.check self;

      nixosConfigurations = builtins.listToAttrs (
        builtins.map
          (host: {
            name = host.name;
            value = lib.nixosSystem {
              inherit system pkgs;
              modules = [
                ./configuration.nix
                agenix.nixosModules.default
                {
                  _module.args.agenix = agenix.packages.${system}.default;
                }
                ./modules/modules.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.ruben = import ./home/home.nix;
                  home-manager.backupFileExtension = "backup";
                  home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
                }
              ] ++ host.nixosModules;
            };
          })
          (import ./hosts.nix { inherit nixos-hardware disko; })
      );
    };
}
