{ config, pkgs, lib, ... }:

{ environment.systemPackages = [pkgs.xwayland-satellite]; }