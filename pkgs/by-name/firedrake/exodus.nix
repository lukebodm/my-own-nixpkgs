{ stdenv, fetchurl, cmake, gfortran
, netcdf, hdf5 }:

stdenv.mkDerivation rec {
  version = "5.24";
  name = "exodus-${version}";

  src = fetchurl {
    url = "http://ftp.mcs.anl.gov/pub/petsc/externalpackages/${name}.tar.bz2";
    sha256 = "0pai6v322x1z09z4zp0plx5p9zg1g4645mpqh3kcfh93az070sn1";
  };


  buildInputs = [
    gfortran
    cmake
    netcdf
    hdf5
  ];

  patches = ./exodus-include.patch;
  sourceRoot = "${name}/exodus";

  meta = with stdenv.lib; {
    homepage = "http://gsjaardema.github.io/seacas";
    description = "A model developed to store and retrieve data for finite element analyses.";
    license = licenses.bsd3;
  };
}
