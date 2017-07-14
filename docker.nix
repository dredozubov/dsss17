{ pkgs ? (import <nixpkgs> { config = {
    allowUnfree = true;         # because we haven't set license params
    allowBroken = true;
  };})
}:

with pkgs;

let dsss17 = pkgs.stdenv.lib.callPackageWith pkgs ./default.nix {}; in

dockerTools.buildImage {
  name = "dsss17";
  runAsRoot = ''
    #!${stdenv.shell}
    ${dockerTools.shadowSetup}
    mkdir /root
  '';

  contents = [ 
    dsss17.options.build 

    bash
    coreutils
    findutils
    gnugrep
    gnused
    gnutar
    less
    time
    tmux
    watch
    which
    xz
    zsh
  ];

  config = {
    Cmd = [ "${stdenv.shell}" ];
    WorkingDir = "/root";
  };
}
