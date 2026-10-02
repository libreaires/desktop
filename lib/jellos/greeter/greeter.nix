{ config, pkgs, lib, ... }:

# block of variables
let

  # set atributes
  libName = "jellos";
  setName = "greeter";

  # values
  emptyArray = [];
  off = false;
  on = true;

  # configuration nest
  cfg = config.${libName}.${setName};

# block of code
in {
  
  # create the options
  options.${libName}.${setName} = {

    # enable option
    enable = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Enable the ${setName}.";
    };

  };

  # set the configuration
  config = lib.mkIf cfg.enable {

    services.greetd.enable = true;
    systemd.services.greetd.serviceConfig.Type = "idle";
  
  };

}
