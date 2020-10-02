{ pkgs, config, ...}:
{
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

  fonts.fonts = with pkgs; [
    iosevka-term
  ];
}
