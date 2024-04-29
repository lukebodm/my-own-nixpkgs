{ stdenv, callPackage, writeText, fetchFromGitHub, python, gfortran
, openmpi, blas, liblapack, hdf5, netcdf, eigen
, sowing, metis, hypre, parmetis, exodus }:

stdenv.mkDerivation rec {
  version = "156a1856fd44f55220132393778f0fda1e6096e3";
  name = "firedrake-petsc-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "petsc";
    rev = "${version}";
    sha256 = "1fmkd818idbiwbr6q9bmsxgwsc7igk13amfvb160llvsj32i93s9";
  };

  buildInputs = [
    sowing
    metis
    parmetis
    hypre
    exodus
    python
    gfortran
    openmpi
    blas
    liblapack
    hdf5
    netcdf
    eigen
  ];

  postPatch = "patchShebangs .";

  configureFlags = [
    "--with-sowing-dir=${sowing}"
    "--with-hdf5-dir=${hdf5}"
    "--with-netcdf-dir=${netcdf}"
    "--with-metis-dir=${metis}"
    "--with-parmetis-dir=${parmetis}"
    "--with-hypre-dir=${hypre}"
    "--with-exodusii-dir=${exodus}"
    "--with-eign-dir=${eigen}"
    "--with-64-bit-indices"
  ];

  setupHook = writeText "setupHook.sh" "export PETSC_DIR=@out@";

  meta = with stdenv.lib; {
    homepage = "https://github.com/firedrakeproject/petsc";
    description = "A suite of data structures and routines for the scalable (parallel) solution of scientific applications modeled by partial differential equations.";
    license = licenses.bsd2;
  };
}
