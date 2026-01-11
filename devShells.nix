{
  mkShell,
  fenix,
  toolchains,
}:
let
  components = [
    "cargo"
    "clippy"
    "rust-src"
    "rustc"
    "rustfmt"
    "rust-analyzer"
  ];
in
builtins.mapAttrs (
  _: value:
  mkShell {
    packages = [
      ((fenix.packages.toolchainOf value).withComponents components)
    ];
  }
) toolchains
