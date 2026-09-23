{ config, pkgs, lib, ... }:

{
  # ===== Imports =====
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./nix/system/boot.nix
        ./nix/system/audio.nix
        ./nix/system/packages.nix
        ./nix/users/jellybean/configuration.nix
        ./nix/devices/jellybean.nix
        ./repros/configuration.nix
    ];
  # ===================

  # ===== DEFAULT OPTIMIZATIONS =====
    xdg.portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    # ----- Timezone -----
      time.timeZone = lib.mkForce null;
      services.tzupdate.enable = true;
    # ---------------------------
    
    # ----- Network -----
      networking.hostName = "nixos";
      networking.wireless.enable = true;
      networking.networkmanager.enable = true;
      networking.firewall.checkReversePath = false;
    # -------------------
    
    nix.settings.auto-optimise-store = true;
  # =================================

  # ===== SYSTEM VERSION =====
    system.stateVersion = "26.05"; # Did you read the comment?
  # ==========================

}
