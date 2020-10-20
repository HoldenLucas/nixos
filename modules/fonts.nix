{ pkgs, config, ... }: {
  fonts = {
    enableDefaultFonts = true;
    fontconfig.defaultFonts.monospace = [ "Iosevka Fixed" ];
    fonts = with pkgs; [ iosevka-fixed ];
  };

  nixpkgs = {
    config.packageOverrides = pkgs: {
      iosevka-fixed = pkgs.iosevka.override {
        set = "fixed";
        privateBuildPlan = {
          family = "Iosevka Fixed";
        };
      };
    };
  };
}
