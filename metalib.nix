{ stdenv, fetchgit, coq, ocamlPackages, haskellPackages, which, ott
}:

stdenv.mkDerivation {
  name = "metalib-${coq.coq-version}-20170713";
  src = fetchgit {
    url = "https://github.com/plclub/metalib.git";
    rev = "0b545f79cfbfe21010328f62860168bc333ab79c";
    sha256 = "13ai7v0vvhb0bgssqw3bkp7c514i314fadyw47nxa4ncmawag6yw";
  };

  buildInputs = [ coq.ocaml coq.camlp5 which coq haskellPackages.lngen ott ]
    ++ (with ocamlPackages; [ findlib ]);
  propagatedBuildInputs = [ coq ];

  enableParallelBuilding = true;

  buildPhase = ''
    (cd Metalib; make)
  '';

  installPhase = ''
    (cd Metalib; make -f CoqSrc.mk DSTROOT=/ COQLIB=$out/lib/coq/${coq.coq-version}/ install)
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/plclub/metalib;
    license = licenses.mit;
    maintainers = [ maintainers.jwiegley ];
    platforms = coq.meta.platforms;
  };

}
