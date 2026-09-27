{ config, pkgs, lib, ... }:

# variables
let

# package arrays
  vpn = with pkgs; [
    wireguard-tools
    proton-vpn
    proton-vpn-cli
  ];

  development = with pkgs; [
    vscodium
    godot
  ];

  tools = with pkgs; [
    obs-studio
  ];

  music = with pkgs; [
    bitwig-studio
    bespokesynth
    renoise
  ];

  art = with pkgs; [
    povray
    libresprite
  ];

  experiments = with pkgs; [
    steam-tui
    gtk-pipe-viewer
    youtube-viewer
    youtube-tui
    yt-dlp
    nimble
    thunderbird
    # minitube
    smplayer
    # experimental vvv
    vitejs
    redlib
    surreal-engine
  ];

  terminal = with pkgs; [
    ghostty
    hyfetch
  ];

  languages = with pkgs; [
    rustc
    rustfmt
    rubyPackages.sinatra
    typescript-go
  ];

  fonts = with pkgs; [
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
      vpn
      development
      music
      languages
      terminal
      experiments
      art
      tools
      fonts
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
