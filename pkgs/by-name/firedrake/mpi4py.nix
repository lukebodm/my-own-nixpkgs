{ stdenv, fetchurl, python
, openmpi, openssh }:

python.pkgs.buildPythonPackage rec {
  name = "mpi4py-2.0.0";

  src = fetchurl {
    url = "https://bitbucket.org/mpi4py/mpi4py/downloads/${name}.tar.gz";
    sha256 = "10fb01595rg17ycz08a23v24akm25d13srsy2rnixam7a5ca0hv5";
  };

  passthru = {
    inherit openmpi;
  };

  # The tests in the `test_spawn` module fail in the chroot build environment.
  # However, they do pass in a pure, or non-pure nix-shell. Hence, we
  # deactivate these particular tests.
  # Unfortunately, the command-line arguments to `./setup.py test` are not
  # correctly passed to the test-runner. Hence, these arguments are patched
  # directly into `setup.py`.
  patchPhase = ''
    sed 's/err = main(cmd.args or \[\])/err = main(cmd.args or ["-v", "-e", "test_spawn"])/' -i setup.py
  '';

  configurePhase = "";

  installPhase = ''
    mkdir -p "$out/lib/${python.libPrefix}/site-packages"
    export PYTHONPATH="$out/lib/${python.libPrefix}/site-packages:$PYTHONPATH"

    ${python}/bin/${python.executable} setup.py install \
      --install-lib=$out/lib/${python.libPrefix}/site-packages \
      --prefix="$out"

    # --install-lib:
    # sometimes packages specify where files should be installed outside the usual
    # python lib prefix, we override that back so all infrastructure (setup hooks)
    # work as expected
  '';

  setupPyBuildFlags = ["--mpicc=${openmpi}/bin/mpicc"];

  buildInputs = [ openmpi ];
  # Requires openssh for tests. Tests of dependent packages will also fail,
  # if openssh is not present. E.g. h5py with mpi support.
  propagatedBuildInputs = [ openssh ];

  # hangs on some test so just disabled for now
  doCheck = false;

  meta = {
    description =
      "Python bindings for the Message Passing Interface standard";
    homepage = "http://code.google.com/p/mpi4py/";
    license = stdenv.lib.licenses.bsd3;
  };
}
