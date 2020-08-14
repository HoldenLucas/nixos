# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

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

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  time.timeZone = "America/New_York";

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
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
    enable = true;
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

  programs.fish.enable = true;

  users.mutableUsers = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      wl-clipboard
      swayidle
      xwayland
      kitty
      firefox
      chromium
      rofi
      brightnessctl
      gammastep
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    toybox
    nmap
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
  ];

  environment = {
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

  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = ["graphical-session-pre.target"];
    after = ["graphical-session-pre.target"];
  };

  systemd.user.services.sway = {
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

  virtualisation.docker.enable = true;

  fonts.fonts = with pkgs; [
    iosevka
  ];
}

