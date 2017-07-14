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
    QuickChick = withPatches [./QuickChick.patch]
      (withSrc ./QuickChick (callPackage ./QuickChick.nix {}));

    paco = callPackage ./paco.nix {};
    vellvm = withSrc ./vellvm (callPackage ./vellvm.nix {
      paco = callPackage ./paco.nix {};
    });

    metalib = callPackage ./metalib.nix {
      haskellPackages = haskellPkgs // haskellDeps;
    };
  };

  withSrc = path: deriv: pkgs.stdenv.lib.overrideDerivation deriv (attrs: {
    src = path;
  });

  withPatches = patches: deriv: pkgs.stdenv.lib.overrideDerivation deriv (attrs: {
    patches = patches;
  });

  haskellDeps = pkgs.recurseIntoAttrs rec {
    lngen = withSrc ./lngen (callPackage ./lngen.nix {});
  };

in {
  dsss17 = dsss17;

  dsss17Env = with pkgs; pkgs.myEnvFun {
    name = "dsss17";
    buildInputs = stdenv.lib.attrValues dsss17 ++ [
      # Coq
      ocaml
      ocamlPackages.camlp5_transitional
      coq_8_6
      coqPackages_8_6.dpdgraph
      coqPackages_8_6.coq-ext-lib

      # ssreflect
      coqPackages_8_6.mathcomp
      coqPackages_8_6.ssreflect

      # QuickChick
      dsss17.QuickChick

      # Vellvm
      dsss17.paco
      dsss17.vellvm

      # Ott
      ott

      # Compcert
      compcert ocamlPackages.menhir

      # lngen
      haskellDeps.lngen

      # Metalib
      dsss17.metalib

      # Editors
      vim
      emacs emacsPackages.proofgeneral_HEAD
    ];
  };
}
