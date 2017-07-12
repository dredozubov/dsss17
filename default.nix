{ pkgs ? (import <nixpkgs> { config = {
    allowUnfree = true;         # because we haven't set license params
    allowBroken = true;
  };})
}:

let
  haskellPkgs = pkgs.haskell.packages.ghc802;

  inherit (pkgs) stdenv;
  inherit (pkgs.haskell.lib) dontCheck dontHaddock;

  callPackage = stdenv.lib.callPackageWith
    (pkgs // haskellPkgs // haskellDeps // dsss17);

  dsss17 = {
  };

  haskellDeps = pkgs.recurseIntoAttrs rec {
  };

  withSrc = path: deriv: pkgs.stdenv.lib.overrideDerivation deriv (attrs: {
    src = path;
  });

  withPatches = patches: deriv: pkgs.stdenv.lib.overrideDerivation deriv (attrs: {
    patches = patches;
  });

in {
  dsss17 = dsss17;
  deps   = haskellDeps;
  pkgs   = haskellPkgs;

  dsss17Env = with pkgs; with haskellPkgs; with dsss17; pkgs.myEnvFun {
    name = "dsss17";
    buildInputs = stdenv.lib.attrValues dsss17 ++ [
      ocaml ocamlPackages.camlp5_transitional
      coq_8_6
      coqPackages_8_6.dpdgraph
      coqPackages_8_6.mathcomp
      coqPackages_8_6.ssreflect
      (withPatches [./QuickChick.patch]
         (withSrc ./QuickChick coqPackages_8_6.QuickChick))
      # (withSrc ~/oss/vellvm vellvm-dsss)
      coqPackages_8_6.coq-ext-lib
      coqPackages_8_6.paco
      compcert ocamlPackages.menhir
      vim
      emacs emacsPackages.proofgeneral_HEAD
    ];
  };
}
