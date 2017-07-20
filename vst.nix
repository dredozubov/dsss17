{ stdenv, fetchgit, coq, ocamlPackages, which, unzip
, tools ? stdenv.cc
}:

stdenv.mkDerivation rec {
  name = "vst-${coq.coq-version}-20170715";

  src = fetchgit {
    url = "https://github.com/PrincetonUniversity/VST.git";
    rev = "666b67de61b7494bb58758edc409701859bfb31c";
    sha256 = "19yfk7p9r5vjfmsia6lsmfzjblai5w9yy7vncj5w7aczchscs743";
  };

  src2 = fetchgit {
    url = "https://github.com/ildyria/CompCert.git";
    rev = "2e2a2663c47d0bd1ae3279bc253662d69dcaf483";
    sha256 = "07nalmydci0wj2x3s3crfylz94zbj52dz5zz188ypd7mjy2m1sw1";
  };

  buildInputs = [ coq.ocaml coq.camlp5 which unzip ]
    ++ (with ocamlPackages; [ findlib menhir ]);
  propagatedBuildInputs = [ coq ];

  enableParallelBuilding = false;

  configurePhase = ''
    rm -fr compcert
    cp -pR ${src2} compcert
    cd compcert
    chmod -R u+w .
    substituteInPlace ./configure --replace '{toolprefix}gcc' '{toolprefix}cc'
    rm -fr powerpc arm
    ./configure -clightgen -prefix $out -toolprefix ${tools}/bin/ '' +
    (if stdenv.isDarwin then "ia32-macosx" else "ia32-linux");

  buildPhase = ''
    make
    cd ..
    COMPCERT=$PWD/compcert > CONFIGURE
    make -j1
  '';

  installPhase = ''
    mkdir -p $out/bin
    #cp compcert/clightgen $out/bin/clightgen
    export COQLIB=$out/lib/coq/${coq.coq-version}/user-contrib/VST
    mkdir -p $COQLIB
    cp -pR floyd msl sepcomp veric version.* $COQLIB
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/PrincetonUniversity/VST;
    license = licenses.bsd3;
    maintainers = [ maintainers.jwiegley ];
    platforms = coq.meta.platforms;
  };

}
