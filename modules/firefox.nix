{ pkgs, config, ... }: {
  home-manager.users.holden.programs.firefox = {
    enable = true;

    package = pkgs.firefox-wayland;

    profiles = {
      "default" = {
        settings = {
          # enables reading userChrome in v69+
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # dpi scaling
          # "layout.css.devPixelsPerPx" = "1.2";
        };
        userChrome = ''
          @-moz-document url("chrome://browser/content/browser.xhtml") {

            /* hides tab bar, use tree style tabs */
            #TabsToolbar {
              visibility: collapse !important;
            }

            /* moves sidebar header to the bottom */
            #sidebar-box {
              -moz-box-direction: reverse;
            }
            #sidebar-switcher-arrow {
              transform: rotate(180deg);
            }
          }
        '';
      };
    };

  };
}
