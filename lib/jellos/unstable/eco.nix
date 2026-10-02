{ config, lib, pkgs, ... }:

# variables
let

  # sets
  cfg = config.lib.jellos.unstable.eco;

in {

  # options
  options.lib.jellos.unstable.eco = {

    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable energy saving options.";
    };

  };

  # configuration
  config = lib.mkIf cfg.enable {

    services = {

      power-profiles-daemon.enable = false;

      tlp = {
        enable = true;

        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "powersave";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_AC = "power";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

          CPU_BOOST_ON_AC = 0;
          CPU_BOOST_ON_BAT = 0;
          CPU_HWP_DYN_BOOST_ON_AC = 0;
          CPU_HWP_DYN_BOOST_ON_BAT = 0;

          CPU_MAX_PERF_ON_AC = 40;
          CPU_MAX_PERF_ON_BAT = 20;

          PCIE_ASPM_ON_AC = "powersave";
          PCIE_ASPM_ON_BAT = "powersave";
          
          USB_AUTOSUSPEND = 1;

          SOUND_POWER_SAVE_ON_AC = 1;
          SOUND_POWER_SAVE_ON_BAT = 1;
        };
      };

    };

  };

}