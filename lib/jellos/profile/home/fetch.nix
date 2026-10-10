{ config, pkgs, lib, ... }:

# variable block
let

  # nests
  cfg = config.snowball.call.home.folder.dot.fetch;

# configuration block
in {

  options.snowball.call.home.folder.dot.fetch = {

    path = lib.mkOption {
      type = lib.types.str;
      default = "snowball";
      description = "dot's path, relative to configuration folder, with no start nor end slashes.";
    };

    url = lib.mkOption {
      type = lib.types.str;
      default = "https://github.com/libreaires/snowball";
      description = "dot's git url.";
    };

  };

  config.home = {

    file.".config/${cfg.path}" = {
      source = builtins.fetchGit {
        url = cfg.url;
        ref = "master";
      };
      recursive = true;
    };

  };

}
