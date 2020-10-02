{ config, pkgs, lib, inputs, name, ... }:
rec {
  imports = [
    (./hardware-configuration + "/${name}.nix")
    inputs.home-manager.nixosModules.home-manager
    (import ./modules device)
  ];

  device = name;

  system.stateVersion = "20.03";
}
