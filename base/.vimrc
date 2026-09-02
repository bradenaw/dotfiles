" set the leader key to the comma
let mapleader=','

if has('autocmd')
  " local settings for specific filetypes
  au FileType make,snippet setlocal ts=8 sts=8 sw=8 noexpandtab
  au FileType go setlocal ts=4 sts=4 sw=4 noexpandtab
  au FileType proto setlocal ts=4 sts=4 sw=4 expandtab
  au FileType javascript,typescript setlocal ts=2 sts=2 sw=2 expandtab

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

let g:grabbedbufnr=1
" 'yank' current buffer (save number)
nmap <leader>by :let g:grabbedbufnr = bufnr('')<cr>
" 'delete' current buffer (save number and closes)
" nmap <leader>bd <leader>by:q<cr>
" 'paste' buffer (open in current window)
nmap <leader>bp :exe "buffer ".g:grabbedbufnr<cr>

" ,t opens new tab.
nmap <leader>t :tabnew<CR>

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

" mc = 'merge conflict', search for merge markers
nmap <leader>mc /\(<<<<<<<\\|\|\|\|\|\|\|\|\\|=======\\|>>>>>>>\)<ENTER>

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


set cursorline
" Put swapfiles in a separate directory.
set dir=~/tmp/swp//
" Show invisible characters as visible.
set list listchars=tab:▸\ ,nbsp:?,conceal:?,precedes:←,extends:→
" Don't autofold, but still allow manual folding.
set foldlevel=100
set formatoptions=tcqlro textwidth=100
" Searches ignore case, unless there's a capital letter present.
set ignorecase smartcase
" Disable mouse since it breaks the native terminal interaction with the clipboard, particularly
" annoying over ssh.
set mouse=
set notermguicolors
set nowrap
set number
" Scroll the window before the cursor line goes off the screen.
set scrolloff=10
" Pick indentation when adding a line.
set smartindent
set splitbelow
set splitright
set wildignore+=*.class
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

source ~/.vim/custom/tabline.vim
source ~/.vim/custom/statusline.vim
source ~/.vim/custom/colors.vim


function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
