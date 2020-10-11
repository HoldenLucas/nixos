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

  security.sudo = {
    enable = true;
  };
}
