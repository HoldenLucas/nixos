{ pkgs, config, ... }: {
  fonts = {
    enableDefaultFonts = true;
    fontconfig.defaultFonts.monospace = [ "Fira Code" ];
    fonts = with pkgs; [ iosevka-term ];
  };

  nixpkgs = {
    config.packageOverrides = pkgs: {
      iosevka-term = pkgs.iosevka.override {
        set = "term";
        privateBuildPlan = {
          family = "Iosevka Term";
          design = [
            "sp-fixed"
            "v-l-italic"
            "v-i-italic"
            "v-g-singlestorey"
            "v-zero-dotted"
            "v-asterisk-high"
            "v-at-long"
            "v-brace-straight"
          ];
        };
      };
    };
  };
}
