{ config, lib, pkgs, ... }:

# variables
let

  # booleans
  NOTO = true;
  JETBRAINS = true;

# configuration
in { home = { # user's home
    packages = [ # home packages
      lib.optional NOTO pkgs.nerd-fonts.noto
      lib.optional JETBRAINS pkgs.nerd-fonts.jetbrains-mono
    ];
  };
}