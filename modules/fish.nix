{ pkgs, config, ... }: {
  home-manager.users.holden.programs.fish = {
    enable = true;
    plugins = [
      # {
      #   name = "zsh-nix-shell";
      #   src = pkgs.fetchFromGitHub {
      #    owner = "chisui";
      #    repo = "zsh-nix-shell";
      #    rev = "b2609ca787803f523a18bb9f53277d0121e30389";
      #    sha256 = "01w59zzdj12p4ag9yla9ycxx58pg3rah2hnnf3sw4yk95w3hlzi6";
      #  };
      # }
    ];
  };
}
