{ pkgs, ... }:

let
  quercus = import ../../packages/quercus.nix { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
    quercus.jellopy
    jetbrains.pycharm-oss
  ];

  # Define as variáveis de ambiente em todo o sistema
  environment.variables = {
    PYTHONDONTWRITEBYTECODE = "1";
  };
}