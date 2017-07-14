{ pkgs }: {
  allowUnfree = true;
  allowBroken = true;
  packageOverrides = super: let self = super.pkgs; in with self; rec {
    dsss17 = super.callPackage /home/nix/dsss17 {};
  };
}
