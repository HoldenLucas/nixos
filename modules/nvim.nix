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
          coc-nvim

          vim-nix
          Recover-vim
          base16-vim
          lightline-vim
          vim-sneak
          vim-polyglot
          fzf-vim
          fzfWrapper
          vimwiki
          tcomment_vim
        ];
        ## manually loadable by calling `:packadd $plugin-name`
        ## however, if a Vim plugin has a dependency that is not explicitly listed in
        ## opt that dependency will always be added to start to avoid confusion.
        #opt = [ phpCompletion elm-vim ];
        ## To automatically load a plugin when opening a filetype, add vimrc lines like:
        ## autocmd FileType php :packadd phpCompletion
      };
    }
  )];
}
