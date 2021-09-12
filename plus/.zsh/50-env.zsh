export EDITOR=vim
export DIFF=vimdiff
export P4DIFF=vimdiff
export LSCOLORS=dxfxgxbxcxedabagacad
export LS_COLORS="di=33:ln=35:so=36:pi=31:ex=32:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=1;37;42:ow=33"

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

export PATH="$HOME/bin:$PATH:/usr/lib/go-1.12/bin"
