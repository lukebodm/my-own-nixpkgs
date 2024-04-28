{ config, stdenv, lib, fetchFromGitHub, cmake, python3Packages }:

stdenv.mkDerivation rec {
  pname = "basix";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "FEniCS";
    repo = "basix";
    rev = "v${version}";
    sha256 = lib.fakeSha256; # Replace with the actual hash
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    python3Packages.python
    python3Packages.numpy
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
  ];

  buildPhase = ''
    mkdir -p build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make
  '';

  installPhase = ''
    cd build
    make install
  '';

  meta = with lib; {
    description = "Basix is a C++/Python library for finite element assembly.";
    homepage = "https://github.com/FEniCS/basix";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ maintainers.example ];
  };
}
