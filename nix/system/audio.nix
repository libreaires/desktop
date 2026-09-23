{ config, pkgs, lib, ... }:

{
  # ===== Pipewire =====
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    # ----- Setup -----
      services.pipewire = {
        
        # ..... Enable .....
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        # ..................

        # ..... JACK .....
          # If you want to use JACK applications, uncomment this
          jack.enable = true;
        # ................

      };
    # -----------------
  # ====================

  # ===== Audio Group Setup =====
    security.pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "@audio"; item = "rtprio"; type = "-"; value = "90"; }
    ];
  # =============================

  # ===== UDEV Settings =====
    services.udev.extraRules = ''
      # Grant write permissions for /dev/cpu_dma_latency to the audio group
      DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
    '';
  # =========================

}