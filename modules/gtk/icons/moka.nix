{ config, lib, pkgs, ... }:

# variables
let

  # strings
  ACCENT = "Lavender";
  VARIANT = "Mocha";
  MODE = "Dark";

in {
  gtk.iconTheme = {
    name = "Moka";
    package = pkgs.moka-icon-theme;
  };

  systemd.user.sessionVariables = config.home.sessionVariables;

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      icon-theme = "Moka";
    };
  };
}