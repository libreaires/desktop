{ config, pkgs, lib, ... }:

{
  # programs
  programs.niri.enable = true;

  # niri packages
  environment.systemPackages = with pkgs; [

    # locker
    veila

    # other
    mako
    swayidle

    # top bar
    ironbar

    # tui files
    lf

    # wallpaper
    awww

    # terminal
    ghostty

    # gui files
    nemo

    # switcher
    walker
    elephant

    # x11
    xwayland-satellite

  ];

  # systemd
  systemd = {
    user.services.niri.enableDefaultPath = false;
    services.greetd.serviceConfig.Type = "idle";
  };

  # security
  security = {
    polkit.enable = true;
    pam.services.veila = {};
  };

  # services
  services = {

    greetd = {
      enable = true;
      settings.default_session = {
        user = "greeter";
        command = "${lib.getExe pkgs.greetd.tuigreet} --time --asterisks --remember --cmd niri-session";
      };
    };

    dbus.enable = true;

  };
}
