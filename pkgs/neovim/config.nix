{ pkgs, pkgs-unstable, lib, ... }:
let
  getDir = dir: lib.attrsets.mapAttrs
    (file: type:
      if type == "directory" then getDir "${dir}/${file}" else builtins.readFile "${dir}/${file}"
    )
    (builtins.readDir dir);

  getLeaveFiles = dir: builtins.listToAttrs (lib.collect (x: x ? value) (lib.attrsets.mapAttrsRecursive
    (path: value: lib.nameValuePair (lib.concatStringsSep "/" path) value)
    (getDir dir))
  );

  getAndImportNixFiles = dir: lib.mapAttrs'
    (name: value:
      lib.nameValuePair
        (lib.strings.removeSuffix ".nix" name)
        (import "${dir}/${name}" { inherit pkgs pkgs-unstable; }))
    (lib.filterAttrs (name: value: lib.strings.hasSuffix ".nix" name) (getLeaveFiles dir));

  getNonNixFiles = dir: lib.filterAttrs (name: value: ! lib.strings.hasSuffix ".nix" name) (getLeaveFiles dir);

  importDir = dir: lib.mapAttrsToList (name: value: (pkgs.writeTextDir name value)) (lib.attrsets.mergeAttrsList [ (getNonNixFiles dir) (getAndImportNixFiles dir) ]);
in
pkgs.stdenvNoCC.mkDerivation {
  name = "nvim-config";
  srcs = (importDir ./config);
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out
    # for now all directories in config directory also have to be created in
    # output dir manually
    mkdir -p $out/lua/config
    for src in $srcs; do
      cp -r $src/* $out
    done
    ls -lsa $out
  '';
}
