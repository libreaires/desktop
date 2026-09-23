{ pkgs, ... }:

let
  quercus = {

    jellopy = pkgs.python3.withPackages (packages: [
      packages.numpy
      packages.requests
      packages.pandas
    ]);

    aestivum = null;

  };
in
quercus