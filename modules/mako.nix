{ pkgs, config, ...}:
{
  home-manager.users.holden.programs.mako = {
    enable = true;

    font = "Iosevka Term 18";
    layer = "overlay";
    #anchor = "top-center";
    margin = "25";
    defaultTimeout = 6000;
    borderSize = 10;
    ignoreTimeout = true;

    # width = 500;
    # height = 80;
    # defaultTimeout = 10000;
    # maxVisible = 10;
    # backgroundColor = config.themes.colors.bg;
    # textColor = config.themes.colors.fg;
    # borderColor = config.themes.colors.blue;
    # progressColor = "over ${config.themes.colors.green}";
  };
}

# text-color=#000000
# background-color=#ffffff
# border-color=#333333
# border-color=#00000055
#
# [hidden]
# format=(and %h more)
# text-color=#777777
#
# [urgency=high]
# text-color=#ffffff
# background-color=#ff0000
#
