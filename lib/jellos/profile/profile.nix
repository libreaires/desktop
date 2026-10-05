{ config, pkgs, lib, ... }:

# block of variables
let

  # set atributes
  libName = "jellos";
  setName = "profile";

  # values
  emptyArray = [];
  off = false;
  on = true;

  # string arrays
  defaultGroups = [
    "wheel"
    "networkmanager"
  ];

  # strings
  configurator = "jellyfish";

  # configuration nest
  cfg = config.${libName}.${setName};

# block of code
in {

  # imports
  imports = [

    # modules
    ../../modules/musnix/configuration.nix
    ../../modules/strainer.nix
    ../../modules/flatpak.nix
    ../../modules/python.nix
    ../../modules/kotlin.nix

    # desktops
    ../../desktops/niri.nix

  ];
  
  # create the options
  options.${libName}.${setName} = {

    # username option
    username = lib.mkOption {
      type = lib.types.str;
      default = "user";
      description = "Add or modify an ${setName}, using it's username.";
    };

    # name option
    name = lib.mkOption {
      type = lib.types.str;
      default = "You";
      description = "Set a custom name for a ${setName}.";
    };

    # groups option
    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = emptyArray;
      description = "Add groups to a ${setName}.";
    };

    # packages option
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = emptyArray;
      description = "Add packages to the ${setName}'s session.";
    };

    strainer = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Allow a curated collection of unfree packages to the ${setName}.";
    };

    experimental = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Set ${setName} as experimental.";
    };

  };

  # set the configuration
  config = lib.mkIf cfg.enable {

    users = {
      users.cfg.username = {

        isNormalUser = true;
        description = cfg.name;
        shell = pkgs.fish;
        extraGroups = defaultGroups + cfg.groups;

      };

    };

    nixpkgs = {

      config = {
        allowBroken = cfg.experimental;
      };

    };

  };

}