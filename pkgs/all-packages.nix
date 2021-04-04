self: pkgs:

with pkgs;

rec {
  geobacterLlvmPackages_latest = callPackage ./development/compilers/geobacter-rust/llvm ({
    inherit (stdenvAdapters) overrideCC;
    buildLlvmTools = buildPackages.llvmPackages_11.tools;
    targetLlvmLibraries = targetPackages.llvmPackages_11.libraries;
  } // lib.optionalAttrs (stdenv.hostPlatform.isi686 && buildPackages.stdenv.cc.isGNU) {
    stdenv = gcc7Stdenv;
  });
  geobacterLlvm_latest = geobacterLlvmPackages_latest.llvm;
  # The same LLVM that Geobacter uses, so you can install the LLVM tools w/o rebuilding.
  geobacterRustcLlvmPackages = geobacterLlvm_latest.override {
    enableSharedLibraries = false;
    enablePolly = true;
    buildType = "Release";
    enableAssertions = true;
  };
  geobacterRust_1_49 = callPackage ./development/compilers/geobacter-rust/latest.nix {
    inherit (darwin.apple_sdk.frameworks) CoreFoundation Security;
  };
  geobacterRust = geobacterRust_1_49;
  geobacterRustPackages = geobacterRust_1_49.packages.stable;
  geobacterRustPlatform = geobacterRustPackages.rustPlatform;
  makeGeobacterRustPlatform = callPackage ./development/compilers/geobacter-rust/make-rust-platform.nix {};
}
