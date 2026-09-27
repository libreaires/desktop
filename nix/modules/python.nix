{ pkgs, ... }:

{
  environment = {

    # packages
    systemPackages = with pkgs; [
      jetbrains.pycharm-oss
    ];

    # set variables
    variables = {
      PYTHONDONTWRITEBYTECODE = "1";
    };

  };
}