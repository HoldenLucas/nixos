{ pkgs, lib, config, ... }:
let
  # thm = config.themes.colors;
  # lock_fork = pkgs.writeShellScript "lock_fork" "sudo /run/current-system/sw/bin/lock &";
  # lock = pkgs.writeShellScript "lock" "swaymsg 'output * dpms off'; sudo /run/current-system/sw/bin/lock; swaymsg 'output * dpms on'";
in {
  home-manager.users.holden.wayland.windowManager.sway = {
    enable = true;

    config = rec {
      fonts = [ "Iosevka Fixed 16" ];

      assigns = {
        "2" = [
          { class = "Chromium"; }
          { app_id = "firefox"; }
          { class = "Firefox"; }
        ];
      };

      bars = [{
        fonts = [ "FontAwesome 10" "Iosevka Fixed 14" ];
        mode = "hide";
        position = "top";
      }];

      colors = rec {
        background = "#EEEEEE";
        # unfocused = {
        #   text = thm.alt;
        #   border = thm.dark;
        #   background = thm.bg;
        #   childBorder = thm.dark;
        #   indicator = thm.fg;
        # };
        # focusedInactive = unfocused;
        # urgent = unfocused // {
        #   text = thm.fg;
        #   border = thm.orange;
        #   childBorder = thm.orange;
        # };
        # focused = unfocused // {
        #   childBorder = thm.blue;
        #   border = thm.blue;
        #   background = thm.dark;
        #   text = thm.fg;
        # };
      };

      gaps = {
        inner = 2;
        smartGaps = true;
        smartBorders = "on";
      };

      focus.followMouse = false;

      modifier = "Mod4";

      window = {
        border = 2;
        hideEdgeBorders = "smart";
      };

      startup = [
        # { command = apps.browser.cmd; }
        # { command = "${pkgs.kdeconnect}/libexec/kdeconnectd"; }
        # {
        #   command =
        #     "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
        # }
        # {
        #   command =
        #     "${pkgs.keepassxc}/bin/keepassxc /home/balsoft/projects/nixos-config/misc/Passwords.kdbx";
        # }
        # { command = "${pkgs.termNote}/bin/noted"; }
        # { command = "${pkgs.nheko}/bin/nheko"; }
        # { command = "${pkgs.xorg.xrdb}/bin/xrdb -merge ~/.Xresources"; }
        #
        # { command = "${pkgs.cantata}/bin/cantata"; }
        #
        # {
        #   command = "swayidle -w before-sleep '${lock_fork}' lock '${lock_fork}' unlock 'pkill -9 swaylock'";
        # }
        { command = "gammastep -O 3000"; }
      ];

      keybindings = let
        # script = name: content: "exec ${pkgs.writeScript name content}";
        # moveMouse = ''
        #   exec "sh -c 'eval `${pkgs.xdotool}/bin/xdotool \
        #         getactivewindow \
        #         getwindowgeometry --shell`; ${pkgs.xdotool}/bin/xdotool \
        #         mousemove \
        #         $((X+WIDTH/2)) $((Y+HEIGHT/2))'"'';
      in {
        "${modifier}+Shift+q" = "kill";
        "${modifier}+minus" = "exec kitty";

        "${modifier}+f" = "exec firefox";

        "${modifier}+n" = "focus left";
        "${modifier}+e" = "focus down";
        "${modifier}+i" = "focus up";
        "${modifier}+o" = "focus right";
        "${modifier}+Shift+n" = "move left";
        "${modifier}+Shift+e" = "move down";
        "${modifier}+Shift+i" = "move up";
        "${modifier}+Shift+o" = "move right";

        "${modifier}+Return" = "workspace 0";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+Shift+Return" = "move container to workspace 0";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";

        "${modifier}+t" = "fullscreen toggle";

        #   "${modifier}+e" = "exec ${apps.editor.cmd}";
        #   "${modifier}+l" = "layout toggle all";
        #
        #   "${modifier}+Left" = "focus child; focus left; ${moveMouse}";
        #   "${modifier}+Right" = "focus child; focus right; ${moveMouse}";
        #   "${modifier}+Up" = "focus child; focus up; ${moveMouse}";
        #   "${modifier}+Down" = "focus child; focus down; ${moveMouse}";
        #   "${modifier}+Control+Left" = "focus parent; focus left; ${moveMouse}";
        #   "${modifier}+Control+Right" = "focus parent; focus right; ${moveMouse}";
        #   "${modifier}+Control+Up" = "focus parent; focus up; ${moveMouse}";
        #   "${modifier}+Control+Down" = "focus parent; focus down; ${moveMouse}";
        #   "${modifier}+Shift+Up" = "move up";
        #   "${modifier}+Shift+Down" = "move down";
        #   "${modifier}+Shift+Right" = "move right";
        #   "${modifier}+Shift+Left" = "move left";
        #
        #   "${modifier}+a" = "focus child; focus left; ${moveMouse}";
        #   "${modifier}+d" = "focus child; focus right; ${moveMouse}";
        #   "${modifier}+w" = "focus child; focus up; ${moveMouse}";
        #   "${modifier}+s" = "focus child; focus down; ${moveMouse}";
        #   "${modifier}+Control+a" = "focus parent; focus left; ${moveMouse}";
        #   "${modifier}+Control+d" = "focus parent; focus right; ${moveMouse}";
        #   "${modifier}+Control+w" = "focus parent; focus up; ${moveMouse}";
        #   "${modifier}+Control+s" = "focus parent; focus down; ${moveMouse}";
        #   "${modifier}+Shift+w" = "move up";
        #   "${modifier}+Shift+s" = "move down";
        #   "${modifier}+Shift+d" = "move right";
        #   "${modifier}+Shift+a" = "move left";
        #
        #   "${modifier}+f" = "fullscreen toggle; floating toggle";
        #   "${modifier}+r" = "mode resize";
        #   "${modifier}+Shift+f" = "floating toggle";
        #
        #   "${modifier}+j" = "focus mode_toggle";
        #   "${modifier}+Escape" = "exec ${apps.monitor.cmd}";
        #
        #   "${modifier}+Print" = script "screenshot"
        #     "${pkgs.grim}/bin/grim Pictures/$(date +'%Y-%m-%d+%H:%M:%S').png";
        #
        #   "${modifier}+Control+Print" = script "screenshot-copy"
        #     "${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy";
        #
        #   "--release ${modifier}+Shift+Print" = script "screenshot-area" ''
        #     ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" Pictures/$(date +'%Y-%m-%d+%H:%M:%S').png'';
        #
        #   "--release ${modifier}+Control+Shift+Print" =
        #     script "screenshot-area-copy" ''
        #       ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy'';
        #
        #   "${modifier}+x" = "move workspace to output right";
        #   "${modifier}+k" = "exec '${pkgs.xorg.xkill}/bin/xkill'";
        #   "${modifier}+F5" = "reload";
        #   "${modifier}+Shift+F5" = "exit";
        #   "${modifier}+Shift+h" = "layout splith";
        #   "${modifier}+Shift+v" = "layout splitv";
        #   "${modifier}+h" = "split h";
        #   "${modifier}+v" = "split v";
        #   "${modifier}+F1" = "move to scratchpad";
        #   "${modifier}+F2" = "scratchpad show";
        #   "${modifier}+F11" = "output * dpms off";
        #   "${modifier}+F12" = "output * dpms on";
        #   "${modifier}+End" = "exec ${lock}";
        #   "${modifier}+p" = "sticky toggle";
        #   "${modifier}+i" =
        #     script "0x0" ''wl-paste | curl -F"file=@-" https://0x0.st | wl-copy'';
        #   "${modifier}+b" = "focus mode_toggle";
        #   "${modifier}+z" = script "lambda-launcher"
        #     "${pkgs.lambda-launcher}/bin/lambda-launcher";
        #   "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        #   "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        #   "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        #   "button2" = "kill";
        #   "--whole-window ${modifier}+button2" = "kill";
      };
      keycodebindings = {
        # "122" = "exec ${pkgs.pamixer}/bin/pamixer -d 2";
        # "123" = "exec ${pkgs.pamixer}/bin/pamixer -i 2";
        # "121" = "exec ${pkgs.pamixer}/bin/pamixer -t";
      };

      # workspaceLayout = "tabbed";
      workspaceAutoBackAndForth = true;
    };

    extraConfig = ''
      input 1:1:AT_Translated_Set_2_keyboard {
        xkb_layout "us"
        xkb_variant "colemak"
        xkb_options "ctrl:nocaps"
        repeat_delay 250
        repeat_rate 25
      }
      input 2:10:TPPS/2_Elan_TrackPoint {
        dwt enabled # disable-while-typing
        tap disabled
        scroll_factor .6
        pointer_accel -0.7
      }
      input * {
        natural_scroll enabled
      }
      # output "*" bg /home/holden/.config/lidar_cloud.png fill
    '';
  };
}

################# old sway cfg
# # class                 border  bground text    indicator child_border
# client.focused          #EEEEEE #EEEEEE #444444 #444444   #EEEEEE
# client.focused_inactive #DDDDDD #DDDDDD #444444 #444444   #444444
# client.unfocused        #BBBBBB #BBBBBB #444444 #BBBBBB   #BBBBBB
# client.urgent           #CB1ED1 #CB1ED1 #FFFFFF #CB1ED1   #CB1ED1
# client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C
#
# # split in horizontal orientation
# bindsym $mod+h split h
#
# # split in vertical orientation
# bindsym $mod+v split v
#
# # enter fullscreen mode for the focused container
# bindsym $mod+t fullscreen toggle
#
# # change container layout (stacked, tabbed, toggle split)
# bindsym $mod+r layout stacking
# bindsym $mod+w layout tabbed
# bindsym $mod+f layout toggle split
#
# # toggle tiling / floating
# bindsym $mod+Shift+space floating toggle
#
# # change focus between tiling / floating windows
# bindsym $mod+d focus mode_toggle
#
# # focus the parent container
# bindsym $mod+a focus parent
#
# # focus the child container
# #bindsym $mod+d focus child
#
# # reload the configuration file
# bindsym $mod+Shift+c reload
# # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
# bindsym $mod+Shift+p restart
# # exit i3 (logs you out of your X session)
# bindsym $mod+Shift+f exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
#
# # resize window (you can also use the mouse for that)
# mode "resize" {
#         # These bindings trigger as soon as you enter the resize mode
#
#         bindsym n resize shrink width 10 px or 10 ppt
#         bindsym e resize grow height 10 px or 10 ppt
#         bindsym i resize shrink height 10 px or 10 ppt
#         bindsym o resize grow width 10 px or 10 ppt
#
#         # same bindings, but for the arrow keys
#         bindsym Left resize shrink width 10 px or 10 ppt
#         bindsym Down resize grow height 10 px or 10 ppt
#         bindsym Up resize shrink height 10 px or 10 ppt
#         bindsym Right resize grow width 10 px or 10 ppt
#
#         # back to normal: Enter or Escape
#         bindsym Return mode "default"
#         bindsym Caps_Lock mode "default"
# }
#
# bindsym $mod+p mode "resize"
#
# # focus_follows_mouse no
# no_focus [window_role="pop-up"]
#
# title_align center
#
# #disable mouse wheel scroll on tabs
# bindsym button4 nop
# bindsym button5 nop
#
# # function keys
# bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
# bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
# bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
# bindsym XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle
# bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
# bindsym XF86MonBrightnessUp exec brightnessctl set +5%
# bindsym XF86AudioPlay exec playerctl play-pause
# bindsym XF86AudioNext exec playerctl next
# bindsym XF86AudioPrev exec playerctl previous
#
# #resize
# bindsym $mod+Ctrl+Right resize shrink width 1 px or 1 ppt
# bindsym $mod+Ctrl+Up resize grow height 1 px or 1 ppt
# bindsym $mod+Ctrl+Down resize shrink height 1 px or 1 ppt
# bindsym $mod+Ctrl+Left resize grow width 1 px or 1 ppt
#
# #output "*" bg /home/holden/.config/lidar_cloud.png fill
#
# bindsym $mod+x move workspace to output right
