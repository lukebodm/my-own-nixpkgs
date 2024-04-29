{ lib, callPackage, fetchFromGitHub, pythonPackages
, openmpi
, coffee, petsc, petsc4py, mpi4py }:

pythonPackages.buildPythonPackage rec {
  version = "98aab7bbbab2945317c1b9ecf5885652cf20e709";
  name = "PyOP2-${version}";

  src = fetchFromGitHub {
    owner = "OP2";
    repo = "PyOP2";
    rev = "${version}";
    sha256 = "1hw8wpbfgw8j48jfhv72pxq33as2mkw9a9k2qg0607d77agjmpz5";
  };

  buildInputs = [
    openmpi
    pythonPackages.cython
    pythonPackages.pytest
    pythonPackages.flake8
    pythonPackages.pycparser
    petsc
  ];

  propagatedBuildInputs = [
    pythonPackages.six
    pythonPackages.numpy
    pythonPackages.decorator
    mpi4py
    coffee
    petsc4py
  ];

  postPatch = ''
    sed -i -e 's|self\._cc = os\.environ\.get(ccenv, cc)|self._cc = '\'"$(type -p mpicxx)"\''' if cpp else '\'"$(type -p mpicc)"\'''|' pyop2/compilation.py
    sed -i -e 's|self\._ld = os\.environ\.get('\'''LDSHARED'\''', ld)|self._ld = None|' pyop2/compilation.py
    sed -i -e 's|os\.environ\['\'''PETSC_DIR'\'''\]|'\'''${petsc}'\'''|' pyop2/utils.py
  '';

  meta = with lib; {
    homepage = "http://op2.github.io/PyOP2/";
    description = "Framework for performance-portable parallel computations on unstructured meshes.";
    license = licenses.bsd3;
  };
}
