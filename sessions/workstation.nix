{ config, lib, pkgs, ... }: {

  specialisation.workstation = {
    configuration = { system.nixos.tags = ["Workstation mode"];

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

      boot.kernel.sysctl = {
        "vm.swappiness" = 1;
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd";
      };
    };

    unstable.configuration = {
      imports = [./build/unstable.nix];
      system.nixos.tags = ["Unstable build"];
    };

  };

}