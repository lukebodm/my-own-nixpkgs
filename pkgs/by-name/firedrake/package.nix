{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "firedrake-env";

  src = pkgs.fetchurl{
    url = "https://raw.githubusercontent.com/firedrakeproject/firedrake/master/scripts/firedrake-install";
    sha256 = "sha256-HD8g4jQOM1MGm42LMY71zdJVsihvwY6+gnvH40SJzt0";# Replace this with the actual sha256 hash of the script
  };

  buildInputs = [
     pkgs.python3
     pkgs.python310Packages.setuptools
     pkgs.python310Packages.packaging
     pkgs.util-linux # for lscpu command
     pkgs.gcc # A C and C++ compiler
     pkgs.gcc10 # If gcc 10 specifically required
     pkgs.gnumake # GNU make
     pkgs.gfortran # A Fortran compiler
     pkgs.openblas # Blas
     pkgs.lapack # Lapack
     pkgs.git # Git
     pkgs.mercurial # Mercurial
     pkgs.autoconf # autoconf
     pkgs.automake # automake
     pkgs.libtool # libtool
     pkgs.cmake # CMake
     pkgs.zlib # zlib
     pkgs.flex # flex
     pkgs.bison # bison
     pkgs.pkg-config
   ];  # Add any necessary dependencies

  phases = ["buildPhase"];

  buildPhase = ''
    echo "WORKING DIRECTORY:"
    pwd
    ls
    mkdir -p $out/bin
    cp $src $out/bin/firedrake-install
    chmod +x $out/bin/firedrake-install
    cd $out/bin
    python3 firedrake-install --help
  '';
}
