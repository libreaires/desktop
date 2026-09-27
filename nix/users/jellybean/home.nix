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

  FONTS = with pkgs; [
    nerd-fonts.noto
    nerd-fonts.jetbrains-mono
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
    configFile."ironbar/config.json" = {
      source = ./ironbar/config.json;
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

}
