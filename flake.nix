{
  description = "compete.toml";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) lib;
        tomlFormat = pkgs.formats.toml { };
        atcoder = import ./atcoder.nix { inherit (lib) optionalAttrs; atcoder = true; };
        problems = import ./atcoder.nix { inherit (lib) optionalAttrs; problems = true; };
      in
      {
        apps.default =
          let
            link-compete-toml = pkgs.writeScript "link-compete-toml" ''
              ln -nsfv ${tomlFormat.generate "atcoder-compete.toml" atcoder} ./atcoder/compete.toml
              ln -nsfv ${tomlFormat.generate "problems-compete.toml" problems} ./problems/compete.toml
            '';
          in
          {
            type = "app";
            program = "${link-compete-toml}";
          };
      }
    );
}
