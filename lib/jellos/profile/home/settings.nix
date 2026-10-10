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

    default = lib.mkOption {
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

  # configuration
  config = when(this.enable) {
    home = {
      username = this.user;
      homeDirectory = "/home/${this.username}";
      stateVersion = nip.version;
      packages = with pkgs; this.packages;

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

    nixpkgs.config.allowBroken = this.experimental;
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