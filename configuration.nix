{ config, pkgs, lib, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in {
  imports =
    [
      ./hardware-configuration.nix
      <nixos-hardware/lenovo/thinkpad/x1/6th-gen>
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
      ./modules/nvim.nix
      ./modules/mako.nix
      ./modules/user.nix
      ./modules/kitty.nix
      ./modules/fish.nix
      ./modules/fonts.nix
      ./modules/sway.nix
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

   nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  nixpkgs = {
    config.allowUnfree = true;

    config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
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

  programs.sway.extraPackages = with pkgs; [
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

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
      lesspass-cli
      docker-compose
      nmap
      steam-run
      libnotify
      httpie
      sublime-merge

      swayidle
      xwayland
      wl-clipboard
      firefox-wayland
      brightnessctl
      # add gammastep once upgraded to unstable
      #gammastep
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
      "xdg/nvim/sysinit.vim".source = ./dotfiles/nvim/init.vim;
      "fish/functions/fisher.fish".source = ./dotfiles/fish/fisher.fish;
    };
  };

  systemd = {
    services.batterynotify = rec {
      description = "Run batterynotify (${startAt})";
      startAt = "minutely";

      serviceConfig = {
        ExecStart = "/run/current-system/sw/bin/batterynotify";
      };
    };
  };

  virtualisation.docker.enable = true;
}
