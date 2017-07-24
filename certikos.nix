{ stdenv, fetchgit, coq, ocamlPackages, which
}:

let targetPlatform = if stdenv.isDarwin then "x86_64-macosx" else "x86_64-linux";

in stdenv.mkDerivation {
  name = "certikos-${coq.coq-version}-20170723";
  src = ./work/pierce/CAL;

  buildInputs = [ coq.ocaml coq.camlp5 which coq ]
    ++ (with ocamlPackages; [ findlib menhir ]);

  propagatedBuildInputs = [ coq ];

  enableParallelBuilding = true;

  configurePhase = ''
    ./configure ${targetPlatform}
  '';

  buildPhase = ''
    make -kj `nproc` quick
  '';

  installPhase = ''
    COQLIB=$out/lib/coq/${coq.coq-version}/user-contrib/certikos
    mkdir -p $COQLIB
    cp -pR *.vo $COQLIB/
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/DeepSpec/dsss17;
    license = licenses.mit;
    maintainers = [ maintainers.dredozubov ];
    platforms = coq.meta.platforms;
  };
}
