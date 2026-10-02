{ config, lib, pkgs, ... }: {

  specialisation.portable = {
    configuration = { system.nixos.tags = ["Portable session"];

      powerManagement = {
        enable = true;
        powertop.enable = true;
      };

      services = {

        auto-cpufreq = {
          enable = true;
          settings = {

            battery = {
              governor = "powersave";
              turbo = "never";
            };

            charger = {
              governor = "performance";
              turbo = "auto";
            };

          };
        };

        logind.settings.Login = {
          HandleLidSwitch = "suspend";
          HandleLidSwitchExternalPower = "suspend";
          HandleLidSwitchDocked = "lock";
        };

      };

    };
  };

}