{ stdenv, fetchFromBitbucket, cmake }:

stdenv.mkDerivation rec {
  version = "5.1.0-p4";
  name = "metis-${version}";

  src = fetchFromBitbucket {
    owner = "petsc";
    repo = "pkg-metis";
    rev = "v${version}";
    sha256 = "1mw87w7jz8kfi7jw3kjfagxbagh2x794z0aj3g9z7w3g6wdbvlrr";
  };

  buildInputs = [
    cmake
  ];

  makeFlags = [ "VERBOSE=1" ];

  meta = with stdenv.lib; {
    homepage = "https://bitbucket.org/petsc/metis";
    description = "A set of serial programs for partitioning graphs, partitioning finite element meshes, and producing fill reducing orderings for sparse matrices.";
  };
}
