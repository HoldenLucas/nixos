{ pkgs, config, lib, inputs, ... }: {
  home-manager.users.holden.home.packages = with pkgs;
    [
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
    ];

    nix = {
     package = pkgs.nixUnstable;
     extraOptions = ''
       experimental-features = nix-command flakes
       '';
    };

    nixpkgs = {
      config.allowUnfree = true;

      # config.packageOverrides = pkgs: {
      #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      # };
    };
}
