{ config, pkgs, lib, ... }: {

  services = {

    greetd = {
      enable = true;
      settings.default_session = {
        user = "greeter";
        command = "${lib.getExe pkgs.greetd.tuigreet} --time --asterisks --remember --cmd niri-session";
      };
    };

  };

  systemd.services.greetd.serviceConfig.Type = "idle";

}

{ config, pkgs, lib, ... }:

# block of variables
let

  # set atributes
  libName = "jellos";
  setName = "greeter";
  greeterName = "tuigreet";

  # values
  emptyArray = [];
  off = false;
  on = true;

  # configuration nest
  cfg = config.${libName}.${setName}.${greeterName};

# block of code
in {
  
  # create the options
  options.${libName}.${setName}.${greeterName} = {

    # enable greeter choice
    enable = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Enable the ${greeterName} ${setName}.";
    };

    # input fields
    settings = {

      clock = {

        # enable option
        enable = lib.mkOption {
          type = lib.types.bool;
          default = on;
          description = "Enable the clock on the ${setName} screen.";
        };

      };

      # password field
      password = {

        # hide password
        hide = lib.mkOption {
          type = lib.types.bool;
          default = on;
          description = "Whether to hide the ${setName} password.";
        };


      };

    };

  };

  # set the configuration
  config = lib.mkIf cfg.enable {

    services.greetd = {
      enable = true;
      settings.default_session = {
        user = "greeter";
        command = "${lib.getExe cfg.package} --time --asterisks --remember --cmd niri-session";
      };
    };

    systemd.services.greetd.serviceConfig.Type = "idle";

  };

}
