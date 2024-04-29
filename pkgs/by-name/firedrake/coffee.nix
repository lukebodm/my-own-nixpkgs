{ lib, callPackage, fetchFromGitHub, pythonPackages
, pulp }:

pythonPackages.buildPythonPackage rec {
  version = "bdbc5fc0a8dfc45683489c6835c3c00cb27c0427";
  name = "firedrake-COFFEE-${version}";

  src = fetchFromGitHub {
    owner = "coneoproject";
    repo = "COFFEE";
    rev = "${version}";
    sha256 = "0b4jgnz05n6lapcnljpnq1p5z6j4bbdnq0mm3c53gzx4r47rkgyk";
  };

  propagatedBuildInputs = [
    pythonPackages.networkx
    pythonPackages.numpy
    pythonPackages.six
    pulp
  ];

  meta = with lib; {
    homepage = "https://github.com/coneoproject/COFFEE";
    description = "A COmpiler For Fast Expression Evaluation (COFFEE).";
    license = licenses.bsd3;
  };
}
