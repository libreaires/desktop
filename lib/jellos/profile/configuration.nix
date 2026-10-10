{ config, pkgs, lib, ... }:

# block of variables
let

  # set atributes
  libName = "snowball";
  setName = "profile";
  currentVersion = "26.05";

  # values
  emptyList = [];
  off = false;
  on = true;

  # string arrays
  defaultGroups = [ "wheel" "networkmanager" ];

  # strings
  configurator = "snowman";
  configuratorName = "Olaf";

  # configuration nest
  cfg = config.${libName}.${setName};

# block of code
in {

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
      default = emptyList;
      description = "Add groups to a ${setName}.";
    };

    # packages option
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = emptyList;
      description = "Add packages to the ${setName}'s session.";
    };

    strainer = {

      enable = lib.mkOption {
        type = lib.types.bool;
        default = off;
        description = "Allow a curated collection of unfree packages to the ${setName}.";
      };

      extraPackages = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = emptyList;
        description = "Add more unfree packages to the ${setName}";
      };
;
    };

    experimental = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Set this ${setName} as a experimental ${setName}.";
    };

    shell = lib.mkOption {
      type = lib.types.package;
      default = pkgs.fish;
      description = "Set a custom shell for the ${setName}.";
    };

  };

  # set the configuration
  config = {

    users = {
      users.${cfg.username} = {

        isNormalUser = true;
        description = cfg.name;
        shell = cfg.shell;
        extraGroups = defaultGroups + cfg.groups;

      };
    };

  }; # vei parece rostinhos vdd oh

}