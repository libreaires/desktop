{ config, pkgs, lib, ... }:

# variable block
let

  # library
  nip = {

    # simple
    on = true;
    off = false;

    # bool
    bool = lib.types.bool;

    # string
    string = lib.types.str;

    # if
    when = lib.mkIf;

    # version
    version = "26.05";

    # list
    list = {
      string = lib.types.listOf lib.types.str;
      package = lib.types.listOf lib.types.package;
      empty = [];
    };

  };

  # nests
  this = config.snowball.call.home;

# code block
in {

  # options
  options.snowball.call.home = {

    enable = lib.mkOption {
      type = nip.bool;
      default = nip.off;
      description = "Enable home manager producer."
    };

    user = lib.mkOption {
      type = nip.string;
      default = "home";
      description = "Configure a home, using a username.";
    };

    packages = lib.mkOption {
      type = nip.list.package;
      default = nip.list.empty;
      description = "Add packages to home."
    };

    theme = {

      cursor = {

        package = lib.mkOption {
          type = nip.package;
          default = pkgs.nordic;
          description = "Set the cursor's package";
        };

        name = lib.mkOption {
          type = nip.string;
          default = "Nordic";
          description = "Set the cursor's name from package";
        };

        size = lib.mkOption {
          type = nip.number;
          default = 16;
          description = "Set cursor's size";
        };

      };

      mode = lib.mkOption {
        type = nip.string;
        default = "dark";
        description = ''Theme mode, can be either "light" or "dark"'';
      };

    };

    preferences = {

      defaults = lib.mkOption {
        type = nip.bool;
        default = on;
        description = "Whether you want the default home programs"
      };

      experimental = lib.mkOption {
        type = nip.bool;
        default = off;
        description = "Whether you want to allow broken packages on a home"
      };

    };

  };

  # configuration
  config = {
    home = {
      username = this.user;
      homeDirectory = "/home/${this.username}";
      stateVersion = nip.version;
      packages = with pkgs; this.packages;

      pointerCursor = {
        enable = true;
        package = cfg.theme.cursor.package; 
        name = cfg.theme.cursor.name;
        size = cfg.theme.cursor.size;
        gtk.enable = true;
      };
    };

    # ADD AS A SEPARATE MODULE
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
    
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-${this.theme.mode}";
        gtk-theme = "Catppuccin-Mocha-Standard-Lavender-Dark";
        icon-theme = "Moka";
      };
    };
    #########################

    nixpkgs.config.allowBroken = this.preferences.experimental;
    systemd.user.sessionVariables = config.home.sessionVariables;

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };

    fonts = {
      fontconfig.enable = true;
    };

  };

};