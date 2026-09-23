{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];
}