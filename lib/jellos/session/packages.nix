{ config, pkgs, lib, ... }:

# variables
let

  SESSION = lib.jellos.session;

  # packages
  LOCKER = pkgs.veila;
  NOTIFICATION = pkgs.mako;
  TERMINAL = pkgs.ghostty;
  WALLPAPER = pkgs.awww;

  # package arrays
  SYSTEM = with pkgs; [
    brightnessctl
  ];

  BAR = with pkgs; [
    ironbar
    upower
  ];

  TOOLS = with pkgs; [
    lf
    nemo
  ];

  LAUNCHER = with pkgs; [
    walker
    elephant
  ];

  # nix files
  GREETER = ../modules/greetd.nix;
  LEGACY = ../modules/legacy.nix;

# configuration
in { 

  options.SESSION = {

    imports = [

      # compositors
      ./compositor/niri.nix

      # lockers
      ./locker/veila.nix

      # notification daemons
      ./notification/mako.nix

      # terminals
      ./teminal/ghostty.nix

      # wallpaper manager
      ./background/awww.nix

      # session packages
      ./packages/brightnessctl.nix

      # top bar
      ./bar/ironbar.nix

    ]



  };
  
  config = {
    programs.niri.enable = true;

    imports = [
      LEGACY
      GREETER
    ];

    environment.systemPackages = lib.flatten [
    ];

    # systemd
    systemd.user.services.niri.enableDefaultPath = false;

    # security
    security.pam.services.veila = {};

  };
}
