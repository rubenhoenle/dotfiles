{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    #agenix.url = "github:ryantm/agenix";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, agenix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
    tantive4 = lib.nixosSystem {
        inherit system pkgs;
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          {
            ruben.backup.enable = true;
          }
          #agenix.nixosModules.default
          agenix.nixosModules.default
          {
            _module.args.agenix = agenix.packages.${system}.default;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            #home-manager.useUserPackages = true;
            home-manager.users.ruben = import ./home/home.nix;
          }
        ];
      };
    };
  };
}
