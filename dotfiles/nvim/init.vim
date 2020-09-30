set termguicolors
set background=light

filetype plugin indent on
syntax enable
let base16colorspace=256
colorscheme base16-grayscale-light

"close quickfix window with esc
augroup vimrcQfClose
    autocmd!
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
augroup END

let mapleader=" "

let g:sneak#s_next = 1
let g:sneak#label = 1

set cursorline
set shiftwidth=2
set tabstop=2
set hidden
set ignorecase
" set list listchars=tab:>>,trail:·,extends:#,nbsp:·
set list listchars=tab:\ \ ,trail:·,extends:#,nbsp:·
set noshowmode
set scrolloff=8
set shortmess+=c
set signcolumn=yes
set smartcase
set updatetime=300

nmap <Leader>t :GFiles --cached --others --exclude-standard<CR>
nmap ; :Buffers<CR>
" run selection or file in Python interpreter, respectively
" xnoremap <leader>p :w !python<cr>
" nnoremap <leader>p :w !python<cr>
" same with node
nnoremap <leader>p :w !node<cr>
" disable search highlighting with esc
nnoremap <silent> <esc> :noh<cr><esc>
" exit insert mode in the terminal with esc
tnoremap <Esc> <C-\><C-n>
" prettier file
nmap <Leader>p :CocCommand prettier.formatFile<CR>
autocmd FileType svelte nmap <buffer> <Leader>p :call CocAction('format')<CR>

""""""""""""""""
""" coc.nvim """
""""""""""""""""
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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
