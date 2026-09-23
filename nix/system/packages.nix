{ config, pkgs, lib, ... }:

{
  # ===== Allow unfree packages =====
    nixpkgs.config.allowUnfree = false;
  # =================================

  # ===== Explorer =====
    programs.firefox = {
      # ----- Getting -----
        enable = true;
        package = pkgs.firefox-esr;
      # -------------------

      # ----- Settings -----
        # working on...
      # -------------------
    };
  # ====================

  # ===== Steam =====
    programs.steam = {
      # ----- Getting -----
        enable = true;
        # packages = pkgs.millennium-steam;
      # -------------------
        
      # ----- Setting -----
        remotePlay.openFirewall = true; # Abra as portas no firewall para o Steam Remote Play
        dedicatedServer.openFirewall = true; # Abra as portas no firewall para o Source Dedicated Server
      # -------------------
    };
  # =================

  # ===== AppImages =====
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
  # =====================

  environment.systemPackages = with pkgs; [
    bazaar

    # niri

    superfile

    pitivi

    glslang
    shaderc
    glslls
    glslviewer
    slang
    nim
    jetbrains.jdk
    lemurs
    kotlin
    appimageupdate
    gearlever
    lite
    surreal-engine
    mg

    jetbrains.idea-oss
    disko
    jetbrains-mono
    jetbrains.pycharm-oss
    docker
    jdk
    jre

    direnv
    neovim

    openjdk

    cmake
    ruby
    clang
    cargo

    kdePackages.kdevelop
    kdePackages.klevernotes

    freshfetch
    steam
    sgdboop
    steamcmd
    blender
    blockbench
    godot3
    lockbook
    bespokesynth
    renoise
    nix-sweep
  ];

  # ===== Flatpak =====
    services.flatpak.enable = true;
  # ===================
}