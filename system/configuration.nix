{ config, pkgs, lib, ... }: {

  imports = [

    # hardware
    ./nix/hosts/current/generated.nix
    ./nix/hosts/current/configuration.nix

    # dependencies
    ./nix/.build/rules.nix
    ./nix/.build/packages.nix
    ./nix/.build/aliases.nix

    # users
    ./nix/users/jellybean.nix
    ./nix/users/libreaires.nix

  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # configuration
  services = {
    pulseaudio.enable = false;
    dbus.enable = true;
    upower.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    pam.loginLimits = [{
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      } {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "90";
      }
    ];
  };

  # xdg
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # ananicy
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  # timezone
  time.timeZone = lib.mkForce null;
  services.tzupdate.enable = true;

  # aliases
  environment.shellAliases = {
    gen-host-config = "export LC_ALL=C.UTF-8 && mkdir -p $HOME/@nixos/nix/hosts/current && sudo nixos-generate-config --dir /tmp/generated-config && sed -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' /tmp/generated-config/hardware-configuration.nix > $HOME/@nixos/nix/hosts/current/generated.nix && sudo rm -rf /tmp/generated-config";
    build-nixos = "sudo nixos-rebuild switch -I nixos-config=$HOME/@nixos/build.nix --show-trace";
    build-home = "home-manager switch --flake $HOME/@nixos/#jellybean || HOME_MANAGER_CONFIG=$HOME/@nixos/nix/users/jellybean/home.nix home-manager switch";
    edit-build-nix = "micro $HOME/@nixos/build.nix";
    edit-user-nix = "micro $HOME/@nixos/nix/users/jellybean/configuration.nix";
    edit-home-nix = "micro $HOME/@nixos/nix/users/jellybean/home.nix";
    edit-niri-nix = "micro $HOME/@nixos/nix/desktops/niri.nix";
    edit-niri-config = "micro $HOME/@nixos/nix/users/jellybean/niri/config.kdl";
    edit-lock-config = "micro $HOME/@nixos/nix/users/jellybean/veila/config.toml";
    edit-topbar-config = "micro $HOME/@nixos/nix/users/jellybean/ironbar/config.json";
    prun-tool = "bash $HOME/Tools/prun/start.sh";
    prun-flatpak = "flatpak uninstall --unused && flatpak uninstall --delete-data";
    checkout-flatpak = "flatpak repair && flatpak --user repair";
  };

  # configuration
  networking.hostName = "nixos";
  networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  # optimization
  nix.settings.auto-optimise-store = true;

  # enable app image support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  fonts = {
    fontconfig.enable = true;
  };

  programs = {

    firefox = {
      enable = true;
      package = pkgs.firefox-esr;
    };

    micro = {
      enable = true;
      settings = {
        autosu = true;
        tabsize = 4;
      };
    };

  };

  # system shell
  programs.fish.enable = true;

  # setting up system sessions
  specialisation = {
    standard.configuration = { inheritParentConfig = true;
      system.nixos.tags = ["Standard session"];
    };

    setup = { inheritParentConfig = false;
      configuration = {
        imports = [./build/aliases.nix];
        system.nixos.tags = ["Setup mode"];

        # user
        users.users.setup = {
          isNormalUser = true;
          description = "Setup user";
          extraGroups = [
            "wheel"
            "networkmanager"
            "setup"
          ];
        };

        # configuration
        services.displayManager.autoLogin = {
          enable = true;
          user = "setup";
        };

        # packages
        environment.systemPackages = with pkgs; [micro];
      };
    };
  };

  # version
  system.stateVersion = "26.05";
}
