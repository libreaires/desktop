{ config, lib, pkgs, ... }:

# variables
let

  # strings
  ACCENT = "Lavender";
  VARIANT = "Mocha";
  MODE = "Dark";

  # booleans
  CUSTOM-CURSOR = true;

  # packages
  CURSOR = pkgs.catppuccin-cursors.mochaDark;

  # numbers
  CURSOR-SIZE = 24;

in {
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-${VARIANT}-Standard-${ACCENT}-${MODE}";
      package = pkgs.catppuccin-gtk.override {
        accents = [lib.toLower ACCENT];
        variant = lib.toLower VARIANT;
      };
    };

    iconTheme = {
      name = "Moka";
      package = pkgs.moka-icon-theme;
    };
  };

  systemd.user.sessionVariables = config.home.sessionVariables;

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-${lib.toLower MODE}";
      gtk-theme = "Catppuccin-${VARIANT}-Standard-${ACCENT}-${MODE}";
      icon-theme = "Moka";
    };
  };

  home = {
    pointerCursor = lib.mkIf CUSTOM-CURSOR {
      enable = true;
      package = CURSOR; 
      name = "catppuccin-${lib.toLower VARIANT}-${lib.toLower MODE}-cursors";
      size = CURSOR-SIZE;
      gtk.enable = true;
    };
  };
}