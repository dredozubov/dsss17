# DeepSpec Summer School 2017

To build all the dependencies needed for the DeepSpec Summer School 2017,
executing the following from a recursive clone of this repository:

    nix-build
    ./result/bin/load-env-dsss17

You will now be in a shell that has every dependeny installed. You could start
Emacs or vi from this shell, for example, and it should then see all those
dependencies.

## Docker image

This Nix project can be pulled as a pre-built Docker image with the following
command:

    docker pull jwiegley/dsss17
    
Running the Docker image will put you into a shell within the dsss17
environment. Make sure to locally map a directory to the `work` directory
inside the container, so that your work is persisted after the container
exits!

    docker run -v $PWD/work:/home/nix/work -ti jwiegley/dsss17
    
This ensures that any work you do in the `/home/nix/work` directory in the
container (the default starting location), will be saved in the `./work`
directory local to where you started the container.

## Notes

Note that when you load the environment, you may see some spurious errors that
can be ignored, for example:

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

