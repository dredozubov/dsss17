# DeepSpec Summer School 2017

To build all the dependencies needed for the DeepSpec Summer School 2017,
executing the following from a recursive clone of this repository:

```
nix-build
./result/bin/load-env-dsss17
```

You will now be in a shell that has every dependeny installed. You could start
Emacs or vi from this shell, for example, and it should then see all those
dependencies.

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
