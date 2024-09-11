call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'elkowar/yuck.vim'
Plug 'tpope/vim-commentary'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'neomake/neomake'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
call plug#end()


let g:python3_host_prog = '~/myenv/bin/python3'
"let $VIMRUNTIME = '/usr/share/nvim/runtime'


