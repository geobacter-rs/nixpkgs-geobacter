self: super:
{
  makeGeobacterRustPlatform = self.callPackage ./development/compilers/geobacter-rust/make-rust-platform.nix {};
  geobacterLlvmPackages_latest = self.callPackage ./development/compilers/geobacter-rust/llvm ({
    inherit (self.stdenvAdapters) overrideCC;
    buildLlvmTools = self.buildPackages.llvmPackages_11.tools;
    targetLlvmLibraries = self.targetPackages.llvmPackages_11.libraries;
  } // self.lib.optionalAttrs (self.stdenv.hostPlatform.isi686 && self.buildPackages.stdenv.cc.isGNU) {
    stdenv = self.gcc7Stdenv;
  });
  geobacterLlvm_latest = self.geobacterLlvmPackages_latest.llvm;
  # The same LLVM that Geobacter uses, so you can install the LLVM tools w/o rebuilding.
  geobacterRustcLlvmPackages = self.geobacterLlvm_latest.override {
    enableSharedLibraries = true;
    enablePolly = true;
    buildType = "Release";
    enableAssertions = true;
  };
  geobacterRust_1_49 = self.callPackage ./development/compilers/geobacter-rust/latest.nix {
    inherit (self.darwin.apple_sdk.frameworks) CoreFoundation Security;
    makeGeobacterRustPlatform = self.makeGeobacterRustPlatform;
    geobacterLlvm_latest = self.geobacterLlvmPackages_latest.llvm;
  };
  geobacterRust = self.geobacterRust_1_49;
  geobacterRustPackages = self.geobacterRust_1_49.packages.stable;
  geobacterRustPlatform = self.geobacterRustPackages.rustPlatform;
}
