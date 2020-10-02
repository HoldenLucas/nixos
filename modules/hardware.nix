{ pkgs, config, lib, ... }:

with rec { inherit (config) device devices deviceSpecific; };
with deviceSpecific; {

  hardware.opengl.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelModules = [ "coretemp" ];
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/e5e277b2-0df2-4ab7-94c6-9b4012a4bf64";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };


  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  };
}
