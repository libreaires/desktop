{ config, pkgs, lib, ... }:

# variables
let

  # packages
  IDE = pkgs.jetbrains.idea-oss;

  # package arrays
  DEPENDENCIES = with pkgs; [
    jetbrains.jdk
  ];

  LANG = with pkgs; [
    kotlin
  ];

# configuration
in {
  environment.systemPackages = lib.flatten [
    DEPENDENCIES
    IDE
    LANG
  ];
}