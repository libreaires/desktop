{ config, pkgs, lib, ... }:

# variables
let

  # booleans
  BYTE-CODE = false;

  # package arrays
  IDE = with pkgs; [
    jetbrains.pycharm-oss
  ];

  LANG = with pkgs; [
    python3Minimal
  ];

# configuration
in {
  environment = {

    # packages
    systemPackages = lib.flatten [
      IDE
      LANG
    ];

    # enviroment variables
    variables = if BYTE-CODE then {}
      else {PYTHONDONTWRITEBYTECODE = "1";};

  };
}