{ config, pkgs, lib, ... }:

{

  # ===== User-based Setup (Specialization) =======================================================
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "lock";
    };

    hardware.graphics = {
      # ----- Drivers ----------------------------------------------------------------------------
        enable = true;
        extraPackages = with pkgs; [
          # .........................................................................
            intel-media-driver      # Driver moderno essencial para o i5-1235U (iHD)
            intel-compute-runtime   # Habilita suporte a OpenCL
            vpl-gpu-rt              # Suporte para processamento
            # intel-media-sdk       # SDK de media legada.
          # .........................................................................
        ];
      # ------------------------------------------------------------------------------------------
    };

    # ===== NixOS Power Management =====
      powerManagement.enable = true;
      powerManagement.powertop.enable = true;
      services.thermald.enable = true;
      services.power-profiles-daemon.enable = true;
    # ==================================

    # ===== Intel Microcodes (Disable if wary). =====
      hardware.cpu.intel.updateMicrocode = true;
    # ===============================================

    # ===== Ananicy =====
      services.ananicy = {
        # ----- Enable -----
        enable = true;
        package = pkgs.ananicy-cpp;
        # ------------------
      };
    # ==============================================================================================

    # ===== NVME ====================================================================================
      services.fstrim.enable = true;
    # ===============================================================================================

    # ===== Swappiness =====
      boot.kernel.sysctl = lib.mkDefault {
        "vm.swappiness" = 10;
      };
    # ======================

    # ===== Kernel ==================================================================================
      boot.kernelModules = ["ideapad_acpi"];
    # ===============================================================================================

    # ===== Security =====
      security.pam.services.kscreenlocker.nodelay = true;
      nixpkgs.config.packageOverrides = pkgs: {
        kdePackages = pkgs.kdePackages // {
          plasma-desktop = pkgs.kdePackages.plasma-desktop.overrideAttrs (oldAttrs: {
            postInstall = (oldAttrs.postInstall or "") + ''
              substituteInPlace $out/share/plasma/shells/org.kde.plasma.desktop/contents/lockscreen/LockScreenUi.qml \
                --replace-fail "interval: 3000" "interval: 0"
            '';
          });
        };
      };
    # ====================
  # ===============================================================================================
}