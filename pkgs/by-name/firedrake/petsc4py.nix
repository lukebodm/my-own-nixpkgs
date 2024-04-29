{ lib, callPackage, fetchFromGitHub, pythonPackages
, openmpi, hdf5, petsc }:

pythonPackages.buildPythonPackage rec {
  version = "fbe23a494ab485f44f00ee37eee9f8be8dcd9eb5";
  name = "firedrake-petsc4py-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "petsc4py";
    rev = "${version}";
    sha256 = "0172rgpyqh2ylr4wv4a79xfls8fbbdb86n4p6r7cx5kdy8d2y05b";
  };

  buildInputs = [
    pythonPackages.cython
    openmpi
    hdf5
    petsc
  ];

  propagatedBuildInputs = [
    pythonPackages.numpy
  ];

  meta = with lib; {
    homepage = "https://bitbucket.org/petsc/petsc4py/";
    description = "Python bindings for PETSc.";
    license = licenses.bsd2;
  };
}
