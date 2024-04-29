{ stdenv, fetchFromBitbucket, cmake
, openmpi
, metis }:

stdenv.mkDerivation rec {
  version = "4.0.3-p4";
  name = "parmetis-${version}";

  src = fetchFromBitbucket {
    owner = "petsc";
    repo = "pkg-parmetis";
    rev = "v${version}";
    sha256 = "088pzcyjgv1i8jbdznxnxy04cd8kk5y3a46vc7mh1na901s0msm2";
  };

  buildInputs = [
    cmake
    openmpi
    metis
  ];

  cmakeFlags = [ "-DGKLIB_PATH=../headers" ];
  makeFlags = [ "VERBOSE=1" ];

  meta = with stdenv.lib; {
    homepage = "http://glaros.dtc.umn.edu/gkhome/metis/parmetis";
    description = "An MPI-based parallel library that implements a variety of algorithms for partitioning unstructured graphs, meshes, and for computing fill-reducing orderings of sparse matrices.";
  };
}
