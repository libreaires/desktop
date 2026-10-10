{ config, pkgs, lib, ... }:

# block of variables
let

  # set atributes
  libName = "snowball";
  actionName = "declare";
  declaredName = "group";

  # values
  emptyList = [];
  empty = null;
  off = false;
  on = true;

  # configuration nest
  cfg = config.${libName}.${actionName}.${declaredName};

# block of code
in {

  options.${libName}.${actionName}.${declaredName} = {

    # id option
    id = lib.mkOption {
      type = lib.types.nullOr lib.types.int;
      default = empty;
      description = "Set the identifier for a ${declaredName}";
    };

    # name option
    name = lib.mkOption {
      type = lib.types.str;
      description = "Add or modify an ${declaredName}, using it's name.";
    };

    # members option
    members = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = emptyList;
      description = "Add members to a ${declaredName}.";
    };

  };

  # set the configuration
  config = {
    users.groups.${cfg.name} = {
      gid = cfg.id;
      members = cfg.members;
    }
  };

}