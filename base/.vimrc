" set the leader key to the comma
let mapleader=','

" Speed up CtrlP with ag
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ --ignore .git5_specs
    \ --ignore review
    \ -g ""'

if has('autocmd')
  " turn filetype off per the pathogen instructions at
  " http://www.vim.org/scripts/script.php?script_id=2332
  filetype off

  call pathogen#runtime_append_all_bundles()

  " turn filetype back on after calling pathogen
  filetype on
  filetype plugin on

  " set filetypes for a given extension
  au BufRead,BufNewFile *.R set ft=R
  au BufRead,BufNewFile *.snippets set ft=snippet

  " local settings for specific filetypes
  au FileType make,snippet setlocal ts=8 sts=8 sw=8 noexpandtab
  au FileType go setlocal ts=4 sts=4 sw=4 noexpandtab

  " Go to last viewed tab
  let g:lasttab = 1
  nmap T :exe "tabn ".g:lasttab<CR>
  au TabLeave * let g:lasttab = tabpagenr()

  let g:gitgutter_sign_added='++'
  let g:gitgutter_sign_modified='~~'
  let g:gitgutter_sign_removed='__'
  let g:gitgutter_sign_removed_first_line='‾‾'
  let g:gitgutter_sign_modified_removed='__'

  let g:SignatureMarkTextHL="'SignatureMarkText'"
  let g:SignatureMarkerTextHL="'SignatureMarkerText'"

  let g:indent_guides_auto_colors = 0
  "let g:indent_guides_start_level = 2
  "let g:indent_guides_guide_size = 1

  let g:go_fmt_fail_silently = 1
  let g:rustfmt_autosave = 1

  augroup BgHighlight
    autocmd!
    autocmd BufEnter * call SetColorColumn()
    autocmd WinEnter * call SetColorColumn()
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set colorcolumn=0
    autocmd WinLeave * set nocursorline
  augroup END

  autocmd BufRead,BufNewFile *.bzl set filetype=python
  autocmd BufRead,BufNewFile BUILD set filetype=python
  autocmd BufRead,BufNewFile *.pyst set filetype=python
endif

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" source custom functions
source ~/.vim/custom/functions.vim

" map ,w to StripTrailingWhitespaces()
nnoremap <silent> <leader>w :call StripTrailingWhitespaces()<cr>

" toggle invisibles with ,i
nmap <leader>i :set list!<cr>

" toggle relative line numbering with ,r
nmap <leader>r :set rnu!<cr>

" toggle cursorline highlighting
nmap <leader>c :set cursorline!<cr>

" toggle spellcheck with ,s
nmap <leader>s :set spell!<cr>

" toggle previous buffer with ,,
nmap <leader><leader> <c-^>

" clear search highlighting
nmap <return> :nohlsearch<cr>

" open files in the same directory as the current file
cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" open current buffer in new tab
noremap <leader>n :vs<CR><C-W>T

" move current buffer to new tab
noremap <leader>T <C-W>T

" opens CtrlP in a new tab
noremap <leader><C-P> :tabnew<CR>:CtrlP<CR>

" show highlight group information
map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <leader>ggo :let g:gitgutter_diff_args='origin/master'<cr>:GitGutterSignsDisable<cr>:GitGutterSignsEnable<cr>
nmap <leader>ggc :let g:gitgutter_diff_args=''<cr>:GitGutterSignsDisable<cr>:GitGutterSignsEnable<cr>

let g:grabbedbufnr=1
" 'yank' current buffer (save number)
nmap <leader>by :let g:grabbedbufnr = bufnr('')<cr>
" 'delete' current buffer (save number and closes)
nmap <leader>bd <leader>by:q<cr>
" 'paste' buffer (open in current window)
nmap <leader>bp :exe "buffer ".g:grabbedbufnr<cr>

" \t opens new tab.
nmap <leader>t :tabnew<CR>

" H and L navigate between tabs.
nmap H :tabp<CR>
nmap L :tabn<CR>

" Ctrl+direction move between windows in a split.
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" Make j and k navigate by visual lines, not actual lines.  If a line overflows
" to the next line, j and k can navigate to the overflowed portion.
nmap j gj
nmap k gk

" Press * to search for highlighted text in visual mode.
vnoremap * y/<c-r>"<cr>N
nnoremap * *N

nmap <leader>ll :LineLength 100<cr>
nmap <leader>ls :LineLength 80<cr>

" so typing comments doesn't has a dumb
inoremap # X#

" don't autofold, but still allow manual folding
set foldlevel=100

set t_Co=16
set cursorline
set autoindent
set smartindent
set hidden
set hlsearch
set list
set number
set ruler
set smarttab
set showcmd
set wildmenu
set ignorecase
set smartcase
set scrolloff=5
set backspace=indent,eol,start " backspace over everything
set splitbelow
set splitright
set updatetime=1200
set nowrap
set wildignore+=*.class
" Put swapfiles in a separate directory.
set dir=~/tmp/swp//
set listchars=tab:▸\ ,nbsp:?,conceal:?,precedes:←,extends:→
set sts=4 ts=4 sw=4 expandtab

syntax enable
syntax on

source ~/.vim/custom/tabline.vim
source ~/.vim/custom/statusline.vim
source ~/.vim/custom/colors.vim
