{ lib, callPackage, fetchFromGitHub, pythonPackages
, fiat }:

pythonPackages.buildPythonPackage rec {
  version = "fecac5b4d4ecf4b02b1ee440bdc4a57bfa9f1d87";
  name = "FInAT-${version}";

  src = fetchFromGitHub {
    owner = "FInAT";
    repo = "FInAT";
    rev = "${version}";
    sha256 = "1ad7vzpvlwmx5pgmvj2v8s6n5kdrz02j7wzj25wn974a2ff6pvvd";
  };

  propagatedBuildInputs = [
    pythonPackages.numpy
    fiat
  ];

  meta = with lib; {
    homepage = "https://github.com/FInAT/FInAT";
    description = "FInAT is an attempt to provide a more abstract, smarter library of finite elements.";
    license = licenses.mit;
  };
}
