{ lib, fetchFromGitHub, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  version = "8c17257d325f5f040ad1cb74b866956ad42427ca";
  name = "firedrake-ufl-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "ufl";
    rev = "${version}";
    sha256 = "1ryjq5sknaw92z3zrrnfqcvkga3g071bgjf8j42acsh4iw4g6yg1";
  };

  propagatedBuildInputs = [
    pythonPackages.numpy
    pythonPackages.six
  ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/ufl";
    description = "Copy of upstream UFL for use with Firedrake.";
    license = licenses.lgpl3;
  };
}
