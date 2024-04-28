{ lib, stdenv, fetchFromGitHub, cmake, boost, pkgconfig, basix, pugixml, ufcx, openmpi, hdf5, petsc, parmetis, adios2, slepc, python3Packages }:

stdenv.mkDerivation rec {
  pname = "fenicsx";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "dolfinx";
    rev = "v${version}";
    sha256 = "1"; # Replace with the actual hash
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [
    gcc
    boost
    basix
    pugixml
    ufcx
    openmpi
    hdf5
    petsc
    parmetis
    adios2
    slepc
    python3Packages.python
    python3Packages.pybind11
    python3Packages.numpy
    python3Packages.mpi4py
    python3Packages.petsc4py
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
  ];

  buildPhase = ''
    mkdir -p build
    cd build
    cmake .. ${lib.concatStringsSep " " cmakeFlags}
    make
  '';

  installPhase = ''
    cd build
    make install
  '';

  meta = with lib; {
    description = "FEniCSx is a C++/Python library for automated scientific computing, with a high-level mathematical interface.";
    homepage = "https://github.com/FEniCS/dolfinx";
    license = licenses.lgpl3Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ maintainers.example ];
  };
}
