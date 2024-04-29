{ lib, callPackage, fetchFromGitHub, pythonPackages
, openmpi, hdf5, libspatialindex
, ufl, fiat, finat, tsfc, pyop2, petsc, petsc4py, coffee }:

pythonPackages.buildPythonPackage rec {
  version = "a967a34c0f05d3dbfb9be05825777da40a6195dc";
  name = "firedrake-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "firedrake";
    rev = "${version}";
    sha256 = "0flj0ca3b3pmcnak058alx5kfhz0h7s3hz0q7qiciag9m8p6ccnl";
  };

  buildInputs = [
    openmpi
    hdf5
    libspatialindex
    pythonPackages.cython
    pythonPackages.pytest_29
    pythonPackages.pytest_xdist
    pythonPackages.pylint
    petsc
  ];

  propagatedBuildInputs = [
    pythonPackages.h5py
    pythonPackages.six
    pythonPackages.sympy
    pythonPackages.psutil
    pythonPackages.cachetools
    pythonPackages.singledispatch
    pythonPackages.ipython
    pythonPackages.matplotlib
    ufl
    fiat
    finat
    tsfc
    pyop2
    petsc4py
    coffee
  ];

  patches = [ ./firedrake-setup.patch ];

  meta = with lib; {
    homepage = "http://www.firedrakeproject.org";
    description = "Firedrake is an automated system for the portable solution of partial differential equations using the finite element method (FEM).";
    license = licenses.gpl3;
  };
}
