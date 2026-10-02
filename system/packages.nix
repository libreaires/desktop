{ config, pkgs, lib, ... }: {

  # system packages
  environment.systemPackages = with pkgs; [
    nix-search-cli nix-inspect home-manager
    fastfetch git distrobox disktui ffmpeg
    cmatrix fortune espeak banner
    asciiquarium-transparent vlc pitivi
    lemurs appimageupdate gearlever lite
    mg disko docker direnv freshfetch
    obs-studio nix-sweep blender
    blockbench godot3 lockbook
  ];

}