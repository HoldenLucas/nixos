{ config, pkgs, lib, ... }: {

  users.mutableUsers = false;

  users.users.holden = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    shell = pkgs.fish;
    hashedPassword = "$6$xmWOpHL.z6z6$b/Z0ooWQxt/aaWWKSwbs7.CEHGPmT.KRgJA1dVcPRATCZbY9gKzprFev/dGUZ8sPczkTCN4uVGvTqq1jeM1kB.";
  };

  services.mingetty.autologinUser = "holden";

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  security.sudo = {
    enable = true;
    extraConfig = ''
      balsoft ALL = (root) NOPASSWD: /run/current-system/sw/bin/lock
      balsoft ALL = (root) NOPASSWD: /run/current-system/sw/bin/lock this
      balsoft ALL = (root) NOPASSWD: ${pkgs.light}/bin/light -A 5
      balsoft ALL = (root) NOPASSWD: ${pkgs.light}/bin/light -U 5
    '';
  };
  home-manager.useUserPackages = true;
}
