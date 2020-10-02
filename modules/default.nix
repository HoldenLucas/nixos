device:
{ pkgs, lib, ... }: {
  imports = [
      ./nvim.nix
      ./themes.nix
      ./mako.nix
      ./fonts.nix
      ./sway.nix
      ./fish.nix
      ./packages.nix
      ./kitty.nix
      ./users.nix
      ./hardware.nix
      ./network.nix
      ./default.nix
  ];
}
