# add here the default home packages later

# below is a example uhhhhhhhhhhhh


  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-esr;
      profiles.default = {

        name = "Default";
        isDefault = true;

        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = '''';

        userContent = ''
          * {
            font-family: monospace !important;
              border-radius: 0px !important;
              box-shadow: none !important;
          }
        '';

      };
    };

    hyfetch = {

      enable = true;
      # add more later uhhhhhhhhhhh;;

    }
  };

        programs.micro = {
        enable = true;
        settings = {
          autosu = true;
          tabsize = 4;
        };
      };