{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.jdk
    jetbrains.idea-oss
    kotlin
  ];
}