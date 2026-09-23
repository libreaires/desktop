{ config, pkgs, lib, ... }:

# GETTING REPO
  let
    musnix = builtins.fetchGit {
      url = "https://github.com/musnix/musnix.git";
      rev = "8548782f0d1d0928daa3fffde8a008f72219a3f3";
    };
  in

# MIX
{
  # ===== IMPORTING MUSNIX =====
    imports = [ "${musnix}" ];
  # ============================

  musnix.enable = true; # enable musnix, check documentation for checking what it does
  musnix.ffado.enable = true; # firewire audio drivers
  musnix.rtcqs.enable = true; # audio tips on terminal

  # ENABLING THE REALTIME KERNEL REQUIRES COMPILING IT.
  # CAN MESS WITH DRIVERS, SO USE WITH CAUTION!
  # musnix.kernel.realtime = true; 
  # musnix.kernel.packages = pkgs.linuxPackages;
}