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