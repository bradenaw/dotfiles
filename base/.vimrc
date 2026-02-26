" set the leader key to the comma
let mapleader=','

if has('autocmd')
  " turn filetype off per the pathogen instructions at
  " http://www.vim.org/scripts/script.php?script_id=2332
  filetype off

  call pathogen#runtime_append_all_bundles()

  " turn filetype back on after calling pathogen
  filetype on
  filetype plugin on
  set nowrap

  " local settings for specific filetypes
  au FileType make,snippet setlocal ts=8 sts=8 sw=8 noexpandtab
  au FileType go setlocal ts=4 sts=4 sw=4 noexpandtab
  au FileType javascript,typescript setlocal ts=2 sts=2 sw=2 expandtab

  let g:gitgutter_sign_added='++'
  let g:gitgutter_sign_modified='~~'
  let g:gitgutter_sign_removed='__'
  let g:gitgutter_sign_removed_first_line='‾‾'
  let g:gitgutter_sign_modified_removed='__'

  let g:SignatureMarkTextHL="'SignatureMarkText'"
  let g:SignatureMarkerTextHL="'SignatureMarkerText'"

  let g:indent_guides_auto_colors = 0

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

" source custom functions
source ~/.vim/custom/functions.vim

" map ,w to StripTrailingWhitespaces()
nnoremap <silent> <leader>w :call StripTrailingWhitespaces()<cr>

" toggle invisibles with ,i
nmap <leader>i :set list!<cr>

" toggle relative line numbering with ,r
nmap <leader>r :set rnu!<cr>

" toggle spellcheck with ,s
nmap <leader>s :set spell!<cr>

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

" show highlight group information
map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" swap gitgutter diff from showing differences in current commit to differences against origin/main.
nmap <leader>ggo :let g:gitgutter_diff_args='origin/master'<cr>:GitGutterSignsDisable<cr>:GitGutterignsEnable<cr>
nmap <leader>ggc :let g:gitgutter_diff_args=''<cr>:GitGutterSignsDisable<cr>:GitGutterSignsEnable<cr>

let g:grabbedbufnr=1
" 'yank' current buffer (save number)
nmap <leader>by :let g:grabbedbufnr = bufnr('')<cr>
" 'delete' current buffer (save number and closes)
" nmap <leader>bd <leader>by:q<cr>
" 'paste' buffer (open in current window)
nmap <leader>bp :exe "buffer ".g:grabbedbufnr<cr>

" ,t opens new tab.
nmap <leader>t :tabnew<CR>

" box drawing tools
source ~/.vim/custom/box_drawing.vim
nmap <leader>bdg :normal i// hl ─   jk │   jl ┌   hj ┐   kl └   hk ┘   jkl ├   hjk ┤  hjl ┬   hkl ┴   hjkl ┼<ESC>
nmap <leader>bdc :normal o// hl ─   jk │   jl ┌   hj ┐   kl └   hk ┘   jkl ├   hjk ┤  hjl ┬   hkl ┴   hjkl ┼<ENTER><ESC>20o//                                                                                                //<ESC>019k3l
nmap <leader>bdh :normal r╴<ESC>
nmap <leader>bdj :normal r╷<ESC>
nmap <leader>bdk :normal r╵<ESC>
nmap <leader>bdl :normal r╶<ESC>
nmap <leader>bdhl :normal r─<ESC>
nmap <leader>bdjk :normal r│<ESC>
nmap <leader>bdjl :normal r┌<ESC>
nmap <leader>bdhj :normal r┐<ESC>
nmap <leader>bdkl :normal r└<ESC>
nmap <leader>bdhk :normal r┘<ESC>
nmap <leader>bdhk :normal r┘<ESC>
nmap <leader>bdjkl :normal r├<ESC>
nmap <leader>bdhjk :normal r┤<ESC>
nmap <leader>bdhjl :normal r┬<ESC>
nmap <leader>bdhkl :normal r┴<ESC>
nmap <leader>bdhjkl :normal r┼<ESC>
nmap <leader>bds :BoxDrawingStart<ENTER>

" mc = 'merge conflict', search for merge markers
nmap <leader>mc /\(<<<<<<<\\|\|\|\|\|\|\|\|\\|=======\\|>>>>>>>\)<ENTER>

let g:coc_disable_startup_warning = 1
nmap <leader>ch :call CocAction('doHover')<ENTER>
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>cf :call CocActionAsync('format')<ENTER>

inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

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
set textwidth=100
set wildignore+=*.class
set formatoptions=tcqlro
" Put swapfiles in a separate directory.
set dir=~/tmp/swp//
set listchars=tab:▸\ ,nbsp:?,conceal:?,precedes:←,extends:→
set sts=4 ts=4 sw=4 expandtab

syntax enable
syntax on

source ~/.vim/custom/tabline.vim
source ~/.vim/custom/statusline.vim
source ~/.vim/custom/colors.vim

function! MakeLink()
  let line_number = line('.')
  let full_path = expand('%:p')

  let rel_path = ""
  let repo_path = ""
  let repo = ""

  if full_path =~ "^/Users/bw/src/convex/"
    let rel_path = substitute(full_path, "^/Users/bw/src/convex/", "", "")
    let repo_path = "/Users/bw/src/convex"
    let repo = "convex"
  elseif full_path =~ "^/Users/bw/src/public/golang/"
    let rel_path = substitute(full_path, "^/Users/bw/src/public/golang/", "", "")
    let link = "https://godoc.pp.dropbox.com/" . rel_path . "#L" . line_number
    call setreg("+", link)
    echo link . " copied to clipboard"
    return
  else
    echo "File is not in a repo"
    return
  endif
  let rev = substitute(system("cd ". repo_path . "&& git rev-parse main"), '\n\+$', '', '')
  let link = "https://github.com/get-convex/" . repo . "/blob/" . rev . "/" . rel_path . "#L" . line_number
  call setreg("+", link)
  echo link . " copied to clipboard"
endfunction
command! MakeLink call MakeLink()


function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
