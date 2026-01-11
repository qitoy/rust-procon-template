{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      perSystem =
        {
          pkgs,
          inputs',
          ...
        }:
        {
          devShells =
            let
              default = {
                channel = "nightly";
                date = "2026-01-10";
                sha256 = "sha256-JzkZebadEOgY+YazmV8iMozGOpMfo/NEUYfDn4XYMu0=";
              };
              atcoder = {
                channel = "1.89.0";
                sha256 = "sha256-+9FmLhAOezBZCOziO0Qct1NOrfpjNsXxc/8I0c7BdKE=";
              };
            in
            import ./devShells.nix {
              inherit (pkgs) mkShell;
              inherit (inputs') fenix;
              toolchains = {
                inherit default atcoder;
              };
            };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              taplo.enable = true;
              nixfmt.enable = true;
              rustfmt.enable = true;
            };
          };
        };
    };
}
