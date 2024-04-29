# This just brings in everything.
#
# This isn't really informative or overridable in any practical sense.  Could put the closure of the dependencies
# of all the packages declared here instead.  This would be overridable/informative, but a bigger pain to maintain.
#
# Likely this should be added into the python packages set instead of dropped on the top-level.
#
{ pkgs }:

let
  self =
    let
      # Top-level scope extended with this set of packages.
      #
      # Possibly it would make more sense to use the python-level scope instead?
      #
      callPackage = pkgs.newScope self;

    in
      with self; {
        inherit callPackages;

        # Python to use for all this stuff (much of it is python)
        python         = pkgs.python27;
        pythonPackages = python.pkgs;

        # Forked and unavailable packages required by firedrake and its dependencies
        ufl       = callPackage ./ufl.nix       { };
        fiat      = callPackage ./fiat.nix      { };
        finat     = callPackage ./finat.nix     { };
        tsfc      = callPackage ./tsfc.nix      { };
        pyop2     = callPackage ./pyop2.nix     { };
        petsc     = callPackage ./petsc.nix     { };
        petsc4py  = callPackage ./petsc4py.nix  { };
        coffee    = callPackage ./coffee.nix    { };
        firedrake = callPackage ./firedrake.nix { };
        pulp      = callPackage ./pulp.nix      { };
        sowing    = callPackage ./sowing.nix    { };
        metis     = callPackage ./metis.nix     { };
        hypre     = callPackage ./hypre.nix     { };
        parmetis  = callPackage ./parmetis.nix  { };
        exodus    = callPackage ./exodus.nix    { };

        # Incompatible version (something with communicator/datatype cleanup callbacks?)
        mpi4py    = callPackage ./mpi4py.nix { };
      };

in
  self.firedrake
