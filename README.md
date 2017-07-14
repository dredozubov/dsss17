# DeepSpec Summer School 2017

To build all the dependencies needed for the DeepSpec Summer School 2017, you
have several options, listed below.  If you just want the quick path:

- Using Docker: `make pull run`
- As a local Nix environment: `make nix shell`
- Installed into your Nix user environment: `make install`

## Running from a Docker image

This Nix project can be pulled as a pre-built Docker image with the following
command:

    docker pull jwiegley/dsss17

Or by building it locally (note: this takes a very long time):

    docker build -t jwiegley/dsss17 .

Running the Docker image places you in a shell with all the dsss17 software
available. Make sure to locally map a host directory to the `work` directory
inside the container, so your work is persisted after the container exits:

    docker run -v $PWD/work:/home/nix/work -ti jwiegley/dsss17

This ensures any work you do in the `/home/nix/work` directory in the
container (the default starting location), is saved in the `./work` directory
where you started the container.

## Building a separate Nix environment

The default build creates a script, `load-env-dsss17`, which, when executed,
places you in a shell where all the dsss17 dependencies are visible. Simply
execute the following from a recursive clone of this repository:

    git clone --recursive https://github.com/jwiegley/dsss17
    cd dsss17
    nix-build
    ./result/bin/load-env-dsss17

You should now be in a shell with all the dependencies available. However,
some of these dependencies will not be immediately visible to, for example,
Emacs. Figuring out the correct way to invoke `proof-site.el` to load Proof
General takes some work:

    env | grep PATH
    <note down the /bin directory for ProofGeneral>
    <add the parent of this directory to your load-path>
    <now M-x load-library RET proof-site RET>

## Installing binaries into your Nix user environment

To install all the binaries so they are globally visible from your user
environment, you'll first want to create the file
`~/.config/nixpkgs/config.nix`, with at least these contents:

    { pkgs }: {
      allowUnfree = true;
      allowBroken = true;
      packageOverrides = super: let self = super.pkgs; in with self; rec {
        dsss17 = super.callPackage ~/dsss17 {};
      };
    }

This assumes you cloned dsss17 into `~/dsss17`, so please change that path
accordingly. You can now run:

    nix-env -iA nixpkgs.dsss17.options.build

This installs `dsss17`, which makes all the various dependencies globally
available to your user. Emacs will be able to load `proof-site.el` without
having to setup your `load-path` manually, but it may introduce a PATH
conflict with other installations of Coq on your system.

## Notes

If you choose to build the separate environment shell, you may see some
spurious errors that can be ignored, for example:

```
nemo ~/tmp/dsss17$ ./result/bin/load-env-dsss17
Error: _assignFirst found no valid variant!
Error: _assignFirst found no valid variant!
/nix/store/nbf1mkx942cy1kcvkzbvi0dkcvdbq9bc-multiple-outputs.sh: line 13: : bad substitution
Error: _assignFirst found no valid variant!
Error: _assignFirst found no valid variant!
/nix/store/nbf1mkx942cy1kcvkzbvi0dkcvdbq9bc-multiple-outputs.sh: line 13: : bad substitution
/nix/store/nbf1mkx942cy1kcvkzbvi0dkcvdbq9bc-multiple-outputs.sh: line 13: : bad substitution
/nix/store/nbf1mkx942cy1kcvkzbvi0dkcvdbq9bc-multiple-outputs.sh: line 13: : bad substitution
env-dsss17 loaded
```
