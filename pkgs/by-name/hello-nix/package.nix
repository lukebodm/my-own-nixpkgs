{ lib
, stdenv
, fetchFromGitHub
, coreutils
, gcc
}:

stdenv.mkDerivation {
  pname = "hello-nix";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "lukebodm";
    repo = "hello-nix";
    rev = "master";  # You can specify a commit hash or a tag here if needed
    sha256 = "nX0GxGbbZsJatd8uy0hjN1tHDAaGScAEn1pAvVO23Ss=";
  };

  buildInputs = [ coreutils gcc ];

  # Build Phases
  # See: https://nixos.org/nixpkgs/manual/#sec-stdenv-phases
  configurePhase = ''
    declare -xp
  '';

  buildPhase = ''
    gcc "$src/hello.c" -o ./hello
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    cp ./hello "$out/bin/"
  '';
}
