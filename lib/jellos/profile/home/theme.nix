{ config, pkgs, lib, ... }:

# variables
let

  libName = "snowball";
  actionName = "call";
  calledName = "home";
  subCalledName = "theme";
  currentVersion = "26.05";

  MUSIC = with pkgs; [
    bitwig-studio
    bespokesynth
    renoise
  ];

  PETS = with pkgs; [
    wayneko
  ];

in
{

  options.${libName}.${actionName}.${calledName} = {

    enable = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Enable ${calledName} manager producer."
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "home";
      description = "Configure a ${calledName}, using a username.";
    };

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = emptyList;
      description = "Add packages to ${calledName}."
    };

    default = lib.mkOption {
      type = lib.types.bool;
      default = on;
      description = "Whether you want the default ${calledName} programs"
    };

    experimental = lib.mkOption {
      type = lib.types.bool;
      default = off;
      description = "Whether you want to allow broken packages on a ${calledName}"
    }

  };

  config = lib.mkIf cfg.enable {
    home = {
      username = cfg.user;
      homeDirectory = "/home/${cfg.username}";
      stateVersion = currentVersion;
      packages = with pkgs; cfg.packages;

      pointerCursor = {
        enable = true;
        package = pkgs.catppuccin-cursors.mochaDark; 
        name = "catppuccin-mocha-dark-cursors";
        size = 24;
        gtk.enable = true;
      };

      sessionVariables = {
        XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
        XCURSOR_SIZE = "24";
      };
    };

      xdg = {

        # niri configuration file
        configFile."niri/config.kdl" = {
          source = ./niri/config.kdl;
          force = true;
        };

        # locker configuration file
        configFile."veila/config.toml" = {
          source = ./veila/config.toml;
          force = true;
        };

        # top bar configuration and css files
        configFile."ironbar/config.corn" = {
          source = ./ironbar/config.corn;
          force = true;
        };
        configFile."ironbar/style.css" = {
          source = ./ironbar/style.css;
          force = true;
        };

        # terminal configuration files
        configFile."ghostty/config.ghostty" = {
          source = ./ghostty/config.ghostty;
          force = true;
        };
        configFile."ghostty/shaders/smear.glsl" = {
          source = ./ghostty/shaders/smear.glsl;
          force = true;
        };
        configFile."ghostty/shaders/letter.glsl" = {
          source = ./ghostty/shaders/letter.glsl;
          force = true;
        };

        # notification configuration files
        configFile."mako/config" = {
          source = ./mako/config;
          force = true;
        };

        # app launcher configuration file
        configFile."walker/config.toml" = {
          source = ./walker/config.toml;
          force = true;
        };
        configFile."walker/themes/jellybean/style.css" = {
          source = ./walker/themes/jellybean/style.css;
          force = true;
        };
      };

      gtk = {
        enable = true;

        theme = {
          name = "Catppuccin-Mocha-Standard-Lavender-Dark";
          package = pkgs.catppuccin-gtk.override {
            accents = [ "lavender" ];
            variant = "mocha";
          };
        };

        iconTheme = {
          name = "Moka";
          package = pkgs.moka-icon-theme;
        };
      };

      nixpkgs.config.allowBroken = cfg.experimental;

      systemd.user.sessionVariables = config.home.sessionVariables;

      qt = {
        enable = true;
        platformTheme.name = "gtk3";
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Catppuccin-Mocha-Standard-Lavender-Dark";
          icon-theme = "Moka";
        };
      };

    };

    fonts.fontconfig.enable = true;

  };

}