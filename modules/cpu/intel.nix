{ config, pkgs, lib, ... }:

# variables
let

  # booleans
  MICROCODE = true;
  GRAPHICS = true;
  DRIVERS = import ./drivers.nix;

# configuration
in {
  services = {
    thermald.enable = true;
    fstrim.enable = true;
  };

  hardware = {
    graphics = {
      enable = GRAPHICS;
      extraPackages = DRIVERS;
    };

    cpu.intel.updateMicrocode = MICROCODE;
  };
}