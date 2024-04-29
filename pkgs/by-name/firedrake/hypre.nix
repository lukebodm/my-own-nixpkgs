{ stdenv, fetchFromGitHub, cmake
, openmpi }:

stdenv.mkDerivation rec {
  version = "xsdk-0.2.0-rc2";
  name = "hypre-${version}";

  src = fetchFromGitHub {
    owner = "LLNL";
    repo = "hypre";
    rev = "${version}";
    sha256 = "0ql1zs0imv14q511aj5g82mfhlycy8rqa5b6rzzw86c4cslasgch";
  };

  buildInputs = [
    cmake
    openmpi
  ];

  sourceRoot = "source/src";
  preConfigure = "cmakeFlags=\"-DHYPRE_INSTALL_PREFIX=$prefix $cmakeFlags\"";

  makeFlags = [ "VERBOSE=1" ];

  meta = with stdenv.lib; {
    homepage = "http://www.llnl.gov/casc/hypre";
    description = "Parallel solvers for sparse linear systems featuring multigrid methods.";
    license = licenses.gpl2;
  };
}
