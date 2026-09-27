{ config, pkgs, lib, ... }:

{

  # laptop lid
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "lock";
  };

  # drivers
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
    ];
  };

  # configuration
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  services.fstrim.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  boot.kernelModules = ["ideapad_acpi"];

  # ananicy
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

}