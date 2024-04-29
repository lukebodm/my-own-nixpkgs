{ lib, fetchFromGitHub, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  version = "20847cdee0d323726571324f565ff3da6f19e700";
  name = "firedrake-fiat-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "fiat";
    rev = "${version}";
    sha256 = "1id0p06m7mwx8caz30g0cgci2n73mvqf6i6hnm1w08m605fxvwwf";
  };

  propagatedBuildInputs = [
    pythonPackages.numpy
    pythonPackages.sympy
    pythonPackages.six
  ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/fiat";
    description = "Copy of upstream FIAT for use with Firedrake.";
    license = licenses.lgpl3;
  };
}
