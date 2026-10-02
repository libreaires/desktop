{ config, lib, pkgs, ... }: {

  specialisation.eco = {
    configuration = { imports = [./.resources/eco.nix]; system.nixos.tags = ["ECO mode"]; };
  };

}