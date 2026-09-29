{ config, pkgs, lib, ... }:

# variables
let

# package arrays
  TOOLS = with pkgs; [
    wireguard-tools
    proton-vpn
    proton-vpn-cli
  ];

  DEVELOPMENT = with pkgs; [
    vscodium
    godot
    surreal-engine
  ];

  CONTENT-CREATION = with pkgs; [
    obs-studio
  ];

  MUSIC = with pkgs; [
    bitwig-studio
    bespokesynth
    renoise
  ];

  ART = with pkgs; [
    povray
    libresprite
  ];

  TERMINAL = with pkgs; [
    youtube-tui
    steam-tui
    hyfetch
  ];

  NIM-LANG = with pkgs; [
    nimble
  ];

  RUBY-LANG = with pkgs; [
    rubyPackages.sinatra
  ];

  RUST-LANG = with pkgs; [
    rustc
    rustfmt
  ];

  CORN-SUPPORT = with pkgs; [
    corn-cli
  ];

  FONTS = with pkgs; [
    nerd-fonts.noto
    nerd-fonts.jetbrains-mono
  ];

  ICONS = with pkgs; [
    moka-icon-theme
    hicolor-icon-theme
  ];

in
{
  # imports
  imports = [
    ../../modules/strainer.nix
  ];

  # home
  home = {
    username = "jellybean";
    homeDirectory = "/home/jellybean";
    stateVersion = "26.05";

    packages = lib.flatten [
      TOOLS
      DEVELOPMENT
      MUSIC
      NIM-LANG
      RUBY-LANG
      RUST-LANG
      TERMINAL
      ART
      CONTENT-CREATION
      FONTS
      ICONS
      CORN-SUPPORT
    ];

    file.".config/micro/plugins/micro-rust-plugin" = {
      source = builtins.fetchGit {
        url = "https://github.com/rochacbruno/micro-rust-plugin";
        ref = "master";
      };
      recursive = true;
    };

    file.".config/micro/plugins/filemanager" = {
      source = builtins.fetchGit {
        url = "https://github.com/NicolaiSoeborg/filemanager-plugin";
        ref = "master";
      };
      recursive = true;
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    profiles.default = {

      name = "Default";
      isDefault = true;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = '''';

      userContent = ''
        * {
          font-family: monospace !important;
            border-radius: 0px !important;
            box-shadow: none !important;
        }
      '';

    };
  };

  # fonts
  fonts.fontconfig.enable = true;

  # configuration files
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

  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      tabsize = 4;
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.mochaDark; 
    name = "catppuccin-mocha-dark-cursors";
    size = 24;
    gtk.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "24";
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

}
