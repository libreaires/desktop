{ config, pkgs, lib, ... }:

# block of variables
let

  # add (on global session) a legacy option

  # set atributes
  libName = "jellos";
  setName = "session";
  sessionName = "niri";

  # values
  emptyArray = [];
  off = false;
  on = true;

  # configuration nest
  cfg = config.${libName}.${setName}.${sessionName};

# block of code
in {
  
  # create the options
  options.${libName}.${setName}.${sessionName} = {

    # enable option
    enable = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Enable the ${sessionName} ${setName}.";
    };

    # packages option
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = emptyArray;
      description = "Add packages to the ${sessionName} ${setName}.";
    };

  };

  # set the configuration
  config = lib.mkIf cfg.enable {

    # niri compositor
    programs.niri.enable = true;

    # niri session packages
    systemd.user.services.niri = {
      enableDefaultPath = false;
      path = cfg.packages;
    };

  };

}
