call plug#begin(stdpath('data') . '/plugged')
" syntax highlighting for many languages
Plug 'sheerun/vim-polyglot'
" for base16-grayscale-light colorscheme
Plug 'chriskempson/base16-vim'
" adds highlighting for f/F and t/T movements
Plug 'unblevable/quick-scope'
" adds lsp and vscode plugin support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" adds an option to show diff of recovered buffer
Plug 'chrisbra/Recover.vim'
" automatic file specific comments
Plug 'tomtom/tcomment_vim'
" md wiki
" Plug 'vimwiki/vimwiki'
" allows fuzzy searching (left in for posterity, managed separately in nix)
" Plug 'junegunn/fzf.vim'
" calls `filetype plugin indent on` and `syntax enable`
call plug#end()
""""""""""""
""" misc """
""""""""""""
" binds <Leader> to space
let mapleader=" "

" allows hiding buffers instead of closing them
set hidden
" highlights the line containing the cursor
set cursorline
" sets the number of spaces inserted by a tab
set tabstop=2
" sets the default indentation width in spaces (0 means use tabstop)
set shiftwidth=0
" show tabs as two spaces, and visualize other whitespace
set list listchars=tab:\ \ ,trail:·,extends:>>,nbsp:·
" the number of lines always padded above/below the cursor
set scrolloff=8
" Always show signcolumns
set signcolumn=yes
" Don't show |ins-completion-menu| messages (coc)
set shortmess+=c
" ignore case during search
set ignorecase
" unless there is a capitalized letter
set smartcase

" break bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" run selection or file in Python interpreter, respectively
" xnoremap <leader>p :w !python<cr>
" nnoremap <leader>p :w !python<cr>
" disable search highlighting with esc
nnoremap <silent> <esc> :noh<cr><esc>
" exit insert mode in the terminal with esc
tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""
""" colorscheme """
"""""""""""""""""""
set background=light
let base16colorspace=256

" better quickscope colors for grayscale
" must be set before colorscheme
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

colorscheme base16-grayscale-light

""""""""""""""""""
""" quickscope """
""""""""""""""""""
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"""""""""""
""" fzf """
"""""""""""
nmap <Leader>f :Files <CR>
nmap <Leader>t :Buffers<CR>

""""""""""""""""
""" coc.nvim """
""""""""""""""""
let g:coc_global_extensions = ['coc-markdownlint']

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"""""""""""""""
""" vimwiki """
"""""""""""""""
" let g:vimwiki_list = [{'path': '~/vimwiki/', 'links_space_char': '_',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]
"
" " prevent vimwiki from turning all md files into wikis
" let g:vimwiki_global_ext = 0
"
" " add markdown style file links
" let g:vimwiki_markdown_link_ext = 1

