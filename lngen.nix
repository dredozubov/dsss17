{ mkDerivation, base, containers, mtl, parsec, stdenv, syb }:
mkDerivation {
  pname = "lngen";
  version = "0.0.1";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base containers mtl parsec syb ];
  executableHaskellDepends = [ base ];
  homepage = "https://github.com/plclub/lngen";
  description = "Tool for generating Locally Nameless definitions and proofs in Coq, working together with Ott";
  license = stdenv.lib.licenses.mit;
}
