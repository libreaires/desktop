{ config, pkgs, lib, ... }:

# fetch git
let
  musnix = builtins.fetchGit {
    url = "https://github.com/musnix/musnix.git";
    rev = "8548782f0d1d0928daa3fffde8a008f72219a3f3";
  };
in

# mix
{
  # imports
  imports = [ "${musnix}" ];

  # configuration
  musnix.enable = true;
  musnix.rtcqs.enable = true;

  # advanced
  musnix.ffado.enable = true; # firewire audio drivers

  # ENABLING THE REALTIME KERNEL REQUIRES COMPILING IT.
  # CAN MESS WITH DRIVERS, SO USE WITH CAUTION!
  # musnix.kernel.realtime = true; 
  # musnix.kernel.packages = pkgs.linuxPackages;
}