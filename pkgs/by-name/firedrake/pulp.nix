{ lib, fetchFromGitHub, pythonPackages
, glpk, cbc }:

pythonPackages.buildPythonPackage rec {
  version = "1.6.4";
  name = "PuLP-${version}";

  src = fetchFromGitHub {
    owner = "coin-or";
    repo = "pulp";
    rev = "${version}";
    sha256 = "02i915ixrz66bpaka82j0x72kl76sr2b5xdx4ahwdlsffvmv9qnx";
  };

  buildInputs = [
    glpk
    cbc
  ];

  propagatedBuildInputs = [
    pythonPackages.pyparsing
  ];

  postPatch = ''
    sed -i -e 's|^CbcPath = .*$|CbcPath = ${cbc}/bin/cbc|' src/pulp/pulp.cfg.linux
    sed -i -e 's|^GlpkPath = .*$|GlpkPath = ${glpk}/bin/glpsol|' src/pulp/pulp.cfg.linux
  '';

  meta = with lib; {
    homepage = "https://github.com/coin-or/pulp";
    description = "A python Linear Programming API.";
    license = licenses.mit;
  };
}
