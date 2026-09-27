{ config, lib, pkgs, ... }:

{

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    qrca
    spectacle
    drkonqi
    kwrited
    discover
  ];

  # no screen locker delay
  security.pam.services.kscreenlocker.nodelay = true;
  environment.etc."skel/.config/kscreenlockerrc".text =
  ''
    [Daemon]
    Autolock=true
    Timeout=5
  '';

}