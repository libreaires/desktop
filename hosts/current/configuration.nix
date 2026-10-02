{ config, pkgs, lib, ... }:

# variables
let

  # nix files
  CPU = ../../modules/cpu/intel.nix;

  # nix file arrays
  KERNEL = ../../modules/kernel/ideapad.nix;

# configuration
in { imports = [ CPU KERNEL ];

  # kernel modules
  boot.kernelModules = ["ideapad_acpi"];

}