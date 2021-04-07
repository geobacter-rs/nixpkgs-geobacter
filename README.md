# Geobacter Rustc Nix Overlay

This overlay provides nix expressions to build Geobacter's Rust fork, Cargo, and Rustfmt.

One way of installing is by:
```shell
git clone https://github.com/geobacter-rs/nixpkgs-geobacter.git ~/.config/nixpkgs/overlays/nixos-geobacter
```

## Cachix

A binary cache is available, for your pleasure: `cachix use geobacter-rs`.
Don't forget to restart your nix daemon afterwards.

## Packages

The main (and the only ones currently present in the binary cache) packages are:

1. `geobacterRustPackages.rustc`
1. `geobacterRustPackages.cargo`
1. `geobacterRustPackages.rustfmt`
1. `geobacterRustcLlvmPackages` (ie LLVM as used by `rustc`)
