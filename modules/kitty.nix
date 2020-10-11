{ pkgs, config, ...}:
{
  home-manager.users.holden.programs.kitty = {
    enable = true;

    settings = {
      font_size = 15;
      font_family = "Iosevka Term";
      bold_font = "Iosevka Term Bold";
      italic_font = "Iosevka Term Italic";
      bold_italic_font = "Iosevka Term Bold Italic";

      enable_audio_bell = false;
      scrollback_lines = 10000;
      update_check_interval = 0;

      window_padding_width = 2;

      background = "#f7f7f7";
      foreground = "#464646";
      selection_background = "#464646";
      selection_foreground = "#f7f7f7";

      url_color = "#525252";
      cursor = "#464646";
      active_border_color = "#ababab";
      inactive_border_color = "#e3e3e3";
      active_tab_background = "#f7f7f7";
      active_tab_foreground = "#464646";
      inactive_tab_background = "#e3e3e3";
      inactive_tab_foreground = "#525252";
      tab_bar_background = "#e3e3e3";
      color0 = "#f7f7f7";
      color1 = "#7c7c7c";
      color2 = "#8e8e8e";
      color3 = "#a0a0a0";
      color4 = "#686868";
      color5 = "#747474";
      color6 = "#868686";
      color7 = "#464646";
      color8 = "#ababab";
      color9 = "#7c7c7c";
      color10 = "#8e8e8e";
      color11 = "#a0a0a0";
      color12 = "#686868";
      color13 = "#747474";
      color14 = "#868686";
      color15 = "#101010";
      color16 = "#999999";
      color17 = "#5e5e5e";
      color18 = "#e3e3e3";
      color19 = "#b9b9b9";
      color20 = "#525252";
      color21 = "#252525";
    };
  };
}
