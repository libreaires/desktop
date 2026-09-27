{ config, pkgs, lib, ... }:

{

  # imports
  imports = [

    # hardware
    ./nix/hosts/current/generated.nix
    ./nix/hosts/current/configuration.nix

    # system
    ./nix/system/boot.nix
    ./nix/system/audio.nix

    # users
    ./nix/users/jellybean/configuration.nix

  ];

  # xdg
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # timezone
  time.timeZone = lib.mkForce null;
  services.tzupdate.enable = true;

  # aliases
  environment.shellAliases = {
    generate-hardware = "export LC_ALL=C.UTF-8 && mkdir -p $HOME/@nixos/nix/hosts/current && sudo nixos-generate-config --dir /tmp/generated-config && sed -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' /tmp/generated-config/hardware-configuration.nix > $HOME/@nixos/nix/hosts/current/generated.nix && sudo rm -rf /tmp/generated-config";
    nixos-build = "sudo nixos-rebuild switch -I nixos-config=$HOME/@nixos/build.nix --show-trace";
    home-update = "home-manager switch --flake $HOME/@nixos/#jellybean || HOME_MANAGER_CONFIG=$HOME/@nixos/nix/users/jellybean/home.nix home-manager switch";
    nix-edit-build = "micro $HOME/@nixos/build.nix";
    nix-edit-user = "micro $HOME/@nixos/nix/users/jellybean/configuration.nix";
    nix-edit-home = "micro $HOME/@nixos/nix/users/jellybean/home.nix";
    nix-edit-niri = "micro $HOME/@nixos/nix/desktops/niri.nix";
    niri-mix-edit = "micro $HOME/@nixos/nix/users/jellybean/niri/config.kdl";
    lock-mix-edit = "micro $HOME/@nixos/nix/users/jellybean/veila/config.toml";
    bar-mix-edit = "micro $HOME/@nixos/nix/users/jellybean/ironbar/config.json";
    prun-mix-auto = "bash $HOME/Tools/prun/start.sh";
  };

  # configuration
  networking.hostName = "nixos";
  networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  # optimization
  nix.settings.auto-optimise-store = true;

  # default packages
  environment.systemPackages = with pkgs; [
    nix-search-cli
    nix-inspect
    home-manager
    vimPlugins.LazyVim
    fastfetch
    git
    distrobox
    disktui
    ffmpeg
    vlc
    superfile
    pitivi
    glslang
    shaderc
    glslls
    glslviewer
    slang
    nim
    lemurs
    appimageupdate
    micro
    gearlever
    lite
    mg
    disko
    docker
    direnv
    neovim
    cmake
    ruby
    clang
    cargo
    freshfetch
    sgdboop
    steamcmd
    blender
    blockbench
    godot3
    lockbook
    nix-sweep
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.fish.enable = true;

  # version
  system.stateVersion = "26.05";

}
