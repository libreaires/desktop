{ config, pkgs, lib, ... }:

{
  # imports
  imports = [

    # modules
    ../../modules/musnix/configuration.nix
    ../../modules/legacy.nix
    ../../modules/strainer.nix
    ../../modules/flatpak.nix
    ../../modules/python.nix
    ../../modules/kotlin.nix

    # desktops
    ../../desktops/niri.nix

  ];

  # user
  users.users."jellybean" = {

    isNormalUser = true;
    description = "libreaires";
    shell = pkgs.fish;

    # groups
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "owner"
    ];

  };

  # system configuration
  nixpkgs.config.allowBroken = true;
}