{ stdenv, fetchFromBitbucket, ghostscript }:

stdenv.mkDerivation rec {
  version = "1.1.25-p1";
  name = "sowing-${version}";

  src = fetchFromBitbucket {
    owner = "petsc";
    repo = "pkg-sowing";
    rev = "v${version}";
    sha256 = "0mpvq9jdavps5ljd2l1qngsyr96g2mp4ic21zf2bf80qvfjyanyw";
  };


  buildInputs = [
    ghostscript
  ];

  meta = with stdenv.lib; {
    homepage = "https://bitbucket.org/petsc/pkg-sowing";
    description = "Tools that are part of the petsc program development and maintenance environment.";
  };
}
