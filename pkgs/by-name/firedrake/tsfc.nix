{ lib, callPackage, fetchFromGitHub, pythonPackages
, coffee, ufl, fiat, finat }:

pythonPackages.buildPythonPackage rec {
  version = "ee5670ab1ad90aaf8f550de01255c6752583255d";
  name = "firedrake-tsfc-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "tsfc";
    rev = "${version}";
    sha256 = "07v5v1nhcywn2rpdr0380ck120ppzlvpfknmjh1rss6xkzf2s9lf";
  };

  propagatedBuildInputs = [
    pythonPackages.numpy
    pythonPackages.singledispatch
    pythonPackages.six
    coffee
    ufl
    fiat
    finat
  ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/tsfc";
    description = "Form compiler for the Firedrake project.";
    license = licenses.gpl3;
  };
}
