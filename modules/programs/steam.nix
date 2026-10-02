{ config, lib, pkgs, ... }:

# variables
let

  # booleans
  GAMESCOPE = true;
  OPEN-FIREWALL = true;
  TUI = true;
  GRID-BOOP = true;

  # packages
  TUI-PACKAGE = pkgs.steam-tui;

# configuration
in { programs = { # steam programs:
    steam = { # steam gui
      enable = true;
      remotePlay.openFirewall = OPEN-FIREWALL;
      dedicatedServer.openFirewall = OPEN-FIREWALL;
    };

    gamescope = { # steam gamescope
      enable = GAMESCOPE;
      capSysNice = GAMESCOPE;
    };

    sgdboop.enable = GRID-BOOP;
  };

  enviroment = { # steam enviroment
    systemPackages = [ # steam packages
      lib.optional TUI TUI-PACKAGE
    ];
  };

  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
    ];
  };
}