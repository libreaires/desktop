{ config, pkgs, lib, ... }:

# variable block
let

  # nests
  cfg = config.snowball.call.home.folder.dot;

# code block
in {

  # options
  options.snowball.call.home.folder.dot = {

    path = lib.mkOption {
      type = lib.types.str;
      default = "snowball";
      description = "dot's path, relative to configuration folder, with no start nor end slashes.";
    };

    file = lib.mkOption {
      type = lib.types.str;
      default = "log.txt";
      description = "dot's file name, with extension.";
    };

  };

  # configuration
  config.xdg = {

    configFile."${cfg.path}/${cfg.file}" = {
      source = ./${cfg.path}/${cfg.file};
      force = true;
    };

  };

}
