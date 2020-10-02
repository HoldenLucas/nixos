{
  inputs = {
    # nixpkgs-mopidy = {
    #   type = "github";
    #   owner = "NickHU";
    #   repo = "nixpkgs";
    #   ref = "mopidy";
    #   flake = false;
    # };
    # NUR = {
    #   type = "github";
    #   owner = "nix-community";
    #   repo = "NUR";
    #   flake = false;
    # };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    base16-unclaimed-schemes = {
      type = "github";
      owner = "chriskempson";
      repo = "base16-unclaimed-schemes";
      flake = false;
    };
    # home-manager = {
    #   type = "github";
    #   owner = "nix-community";
    #   repo = "home-manager";
    #   ref = "master";
    # };
    # materia-theme = {
    #   type = "github";
    #   owner = "nana-4";
    #   repo = "materia-theme";
    #   flake = false;
    # };
    # nixpkgs-old = {
    #   type = "github";
    #   owner = "nixos";
    #   repo = "nixpkgs";
    #   ref = "nixos-19.03";
    #   flake = false;
    # };
    # weechat-scripts = {
    #   type = "github";
    #   owner = "weechat";
    #   repo = "scripts";
    #   flake = false;
    # };
    # simple-nixos-mailserver = {
    #   type = "git";
    #   url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver";
    #   ref = "master";
    #   flake = false;
    # };
    # nixpkgs-wayland = {
    #   type = "github";
    #   owner = "colemickens";
    #   repo = "nixpkgs-wayland";
    #   flake = false;
    # };
    # weechat-notify-send = {
    #   type = "github";
    #   owner = "s3rvac";
    #   repo = "weechat-notify-send";
    #   flake = false;
    # };
    # yt-utilities = {
    #   type = "git";
    #   url = "ssh://git@github.com/serokell/yt-utilities";
    #   ref = "flake";
    # };
    # mobile-broadband-provider-info = {
    #   type = "git";
    #   url = "https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info";
    #   flake = false;
    # };
    # nixos-fhs-compat = {
    #   type = "github";
    #   owner = "balsoft";
    #   repo = "nixos-fhs-compat";
    # };
  };
  #
  # outputs = { nixpkgs, nix, self, ... }@inputs: {
  #   nixosConfigurations = with nixpkgs.lib;
  #     let
  #       hosts = map (fname: builtins.head (builtins.match "(.*)\\.nix" fname))
  #         (builtins.attrNames (builtins.readDir ./hardware-configuration));
  #       mkHost = name:
  #         nixosSystem {
  #           system = "x86_64-linux";
  #           modules = [ (import ./default.nix) ];
  #           specialArgs = { inherit inputs name; };
  #         };
  #     in genAttrs hosts mkHost;
  #
  #   legacyPackages.x86_64-linux =
  #     (builtins.head (builtins.attrValues self.nixosConfigurations)).pkgs;
  # };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = nixpkgs.lib.nixosSystem {
      modules = [
        # Point this to your original configuration.
        ./configuration.nix
      ];
      # Select the target system here.
      system = "x86_64-linux";
    };
  };
}
