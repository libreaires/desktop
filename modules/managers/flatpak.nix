{ config, lib, pkgs, ... }:

# variables
let

  # package arrays
  STORE = pkgs.bazaar;

# configuration
in {
  services.flatpak.enable = true;
  environment.systemPackages = [STORE];
}