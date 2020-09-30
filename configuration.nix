{ config, pkgs, lib, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixos-hardware/lenovo/thinkpad/x1/6th-gen>
      ./vim.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelModules = [ "coretemp" ];
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/e5e277b2-0df2-4ab7-94c6-9b4012a4bf64";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp2s0.useDHCP = true;
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  time.timeZone = "America/New_York";

  nixpkgs = {
    config.allowUnfree = true;

    config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
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

  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
    };
    trackpoint = {
      sensitivity = 255;
      speed = 255;
    };
    opengl = {
      enable = true;
    };
  };

  powerManagement = {
    powertop.enable = true;
  };

  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    acpid.enable = true;
    tlp.enable = true;
  };

  users.users.holden = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/holden";
    hashedPassword = "$6$xmWOpHL.z6z6$b/Z0ooWQxt/aaWWKSwbs7.CEHGPmT.KRgJA1dVcPRATCZbY9gKzprFev/dGUZ8sPczkTCN4uVGvTqq1jeM1kB.";
  };


  users.mutableUsers = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        wl-clipboard # clipboard
        swayidle
        xwayland # for legacy x apps
        mako # notification daemon

        kitty
        #firefox
        firefox-wayland
        chromium
        rofi
        brightnessctl
        #gammastep
      ];
    };

    fish.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      git
      htop
      acpi
      ripgrep
      exa
      nodejs
      fzf
      lm_sensors
      postgresql
      lesspass-cli
      docker-compose
      nmap
      steam-run
      libnotify
      httpie
      sublime-merge
      (
        pkgs.writeTextFile {
          name = "startsway";
          destination = "/bin/startsway";
          executable = true;
          text = ''
            #! ${pkgs.bash}/bin/bash
            systemctl --user import-environment
            exec systemctl --user start sway.service
          '';
        }
      )
      (
        pkgs.writeTextFile {
          name = "batterynotify";
          destination = "/bin/batterynotify";
          executable = true;
          text = ''
            #! ${pkgs.bash}/bin/bash
            charge=$(cat /sys/class/power_supply/BAT0/capacity)

            if [ "$charge" -lt 100 ]
            then
              # see https://releases.nixos.org/nix-dev/2015-December/019018.html
              # to explain the double single quotes before the $ below
              ${pkgs.libnotify}/bin/notify-send -u critical "''${charge}%"
            fi
          '';
        }
      )
    ];

    etc = {
      "sway/config".source = ./dotfiles/sway/config;
      "kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
      "xdg/nvim/sysinit.vim".source = ./dotfiles/nvim/init.vim;
      "fish/functions/fisher.fish".source = ./dotfiles/fish/fisher.fish;
    };
    variables = {
      KITTY_CONFIG_DIRECTORY="/etc/kitty";
      ZDOTDIR="/etc/nixos/dotfiles/zsh/";
      XDG_DESKTOP_DIR="$HOME/";
    };
  };

  systemd = {
    user.targets.sway-session = {
      description = "Sway compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = ["graphical-session-pre.target"];
      after = ["graphical-session-pre.target"];
    };

    services.batterynotify = rec {
      description = "Run batterynotify (${startAt})";
      startAt = "minutely";

      serviceConfig = {
        ExecStart = "/run/current-system/sw/bin/batterynotify";
      };
    };

    user.services = {
      sway = {
        description = "Sway - Wayland window manager";
        documentation = ["man:sway(5)"];
        bindsTo = [ "graphical-session.target" ];
        wants = ["graphical-session-pre.target"];
        after = ["graphical-session-pre.target"];
        environment.PATH = lib.mkForce null;
        serviceConfig = {
          Type = "simple";
          ExecStart = ''
            ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
          '';
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };

      # see https://releases.nixos.org/nix-dev/2016-February/019620.html
      # to explain systemd timers

      #batterynotify = rec {
      #  description = "Run batterynotify (${startAt})";
      #  startAt = "minutely";

      #  serviceConfig = {
      #    ExecStart = "/run/current-system/sw/bin/batterynotify";
      #  };
      #};
    };

  };

  virtualisation.docker.enable = true;

  fonts.fonts = with pkgs; [
    #unstable.iosevka
    iosevka-term
  ];
}
