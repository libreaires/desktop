{...}: { # micro plugin from: github.com/rochacbruno/micro-rust-plugin
  home = {
    file.".config/micro/plugins/micro-rust-plugin" = {
      source = builtins.fetchGit {
        url = "https://github.com/rochacbruno/micro-rust-plugin";
        ref = "master";
      };
      recursive = true;
    };
  };
}