{ config, pkgs, lib, ... }:

# variables
let

  # git
  MUSNIX = builtins.fetchGit {
    url = "https://github.com/musnix/musnix.git";
    rev = "8548782f0d1d0928daa3fffde8a008f72219a3f3";
  };

  # booleans
  RTCQS = true;
  FIREWIRE = true;
  REALTIME = false;

# configuration
in { imports = ["${MUSNIX}"];
  musnix = {
    enable = true;
    rtcqs.enable = RTCQS;
    ffado.enable = FIREWIRE;
    kernel.realtime = REALTIME;
  };
}