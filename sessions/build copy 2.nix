{ config, lib, pkgs, ... }: {

  specialisation = {

    standard.configuration = {
      system.nixos.tags = ["Standard mode"];
    };

    portable.configuration = {
      system.nixos.tags = ["Portable mode"];

      # configuration
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

    eco.configuration = {
      imports = [./.resources/eco.nix];
      system.nixos.tags = ["ECO mode"];
    };

    workstation.configuration = {
      system.nixos.tags = ["Workstation mode"];
      powerManagement = {
        cpuFreqGovernor = "performance";
      };

      services = {
        tlp.enable = false; 
        power-profiles-daemon.enable = false;
        auto-cpufreq.enable = false;
        thermald.enable = false; 
      };

      nix.settings = {
        cores = 0; 
        max-jobs = "auto";
        daemon-cpu-class = "normal";
      };

      boot = {
        kernel.sysctl = {
          "vm.swappiness" = 1;
        };
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd";
      };
    };

    setup = {
      inheritParentConfig = false;
      configuration = {
        imports = [./build/aliases.nix];
        system.nixos.tags = ["Setup mode"];

        # user
        users.users.setup = {
          isNormalUser = true;
          description = "Setup user";
          extraGroups = [
            "wheel"
            "networkmanager"
            "setup"
          ];
        };

        # configuration
        services.displayManager.autoLogin = {
          enable = true;
          user = "setup";
        };

        # packages
        environment.systemPackages = with pkgs; [micro];
      };
    };

    unstable.configuration = {
      imports = [./build/unstable.nix];
      system.nixos.tags = ["Unstable build"];
    };

  };

}