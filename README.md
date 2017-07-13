# DeepSpec Summer School 2017

To build all the dependencies needed for the DeepSpec Summer School 2017,
executing the following from a recursive clone of this repository:

```
nix-build
./result/bin/load-env-dsss17
```

You will now be in a shell that has every dependency installed. You could start
Emacs or vi from this shell, for example, and it should then see all those
dependencies.
