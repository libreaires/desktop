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

  # fonts
  fonts.fontconfig.enable = true;

  # configuration files
  xdg = {
    configFile."niri/config.kdl" = {
      source = ./niri/config.kdl;
      force = true;
    };
    configFile."veila/config.toml" = {
      source = ./veila/config.toml;
      force = true;
    };
    configFile."ironbar/config.corn" = {
      source = ./ironbar/config.corn;
      force = true;
    };
    configFile."ironbar/style.css" = {
      source = ./ironbar/style.css;
      force = true;
    };
    configFile."ghostty/config.ghostty" = {
      source = ./ghostty/config.ghostty;
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
    iconTheme = {
      name = "Moka";
      package = pkgs.moka-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      icon-theme = "Moka";
    };
  };

}
