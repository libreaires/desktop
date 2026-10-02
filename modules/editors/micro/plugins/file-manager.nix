{...}: { # micro plugin from: github.com/NicolaiSoeborg/filemanager-plugin
  home = {
    file.".config/micro/plugins/filemanager" = {
      source = builtins.fetchGit {
        url = "https://github.com/NicolaiSoeborg/filemanager-plugin";
        ref = "master";
      };
      recursive = true;
    };
  };
}