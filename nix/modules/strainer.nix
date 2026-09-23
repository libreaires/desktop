{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steamcmd"
    "bitwig-studio"
    "renoise"
    "steam-unwrapped"
    "bitwig-studio6"
  ];
}