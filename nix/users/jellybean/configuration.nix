{ config, pkgs, lib, ... }:
let
  vpn = with pkgs; [
    wireguard-tools
    proton-vpn
    proton-vpn-cli
  ];
  dev = with pkgs; [
    vscodium
    godot
  ];
  media = with pkgs; [
    obs-studio
  ];
  music = with pkgs; [
    bitwig-studio
  ];
  art = with pkgs; [
    povray
    libresprite
  ];
  tests = with pkgs; [
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
  ];
  tui = with pkgs; [
    hyfetch
  ];
  langs = with pkgs; [
    rustc
    rubyPackages.sinatra
    typescript-go
  ];
in
{
  imports = [
    ../../modules/musnix/mus.nix
    ../../modules/legacy.nix
    ../../modules/strainer.nix
    ../../desktops/kde.nix
    ../../modules/flatpak.nix
  ];
  # ===== Users =====
    users.users."jellybean" = {
      isNormalUser = true;
      description = "justcallmeaires";
      extraGroups = [ "wheel" "networkmanager" "audio" "owner" ];
      packages = lib.flatten [
        vpn
        dev
        music
        langs
        tui
        tests
        art
        media
      ];
    };
  # =================
}