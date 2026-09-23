{ config, pkgs, lib, ... }:

{
  # PREDEFINED REPROS CONFIGURATION
  environment.systemPackages = with pkgs; [
    asciidoc
    nix-search-cli
    nix-inspect
    home-manager
    fastfetch
    git
    gnome-disk-utility
    disktui
    ffmpeg
    vlc
  ];
}