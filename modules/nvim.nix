{ pkgs, ... }:
{
  environment.variables = { EDITOR = "nvim"; };

  environment.systemPackages = with pkgs; [
    (neovim.override {
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;

      configure.customRC = builtins.readFile ../dotfiles/nvim/init.vim;

      configure.packages.myNvimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          # required because the vim-plug version can't find the fzf bin on nix
          fzf-vim
        ];
      };
    }
  )];
}
