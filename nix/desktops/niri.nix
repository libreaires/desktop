{ config, pkgs, lib, ... }:

{
  # programs
  programs.niri.enable = true;

  # niri packages
  environment.systemPackages = with pkgs; [
    veila
    mako
    swayidle
    ironbar
    elephant
    lf
    awww
    ghostty
    nemo
    walker
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
