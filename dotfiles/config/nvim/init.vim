call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'roxma/nvim-yarp'
Plug 't9md/vim-choosewin'
Plug 'flazz/vim-colorschemes'
Plug 'jremmen/vim-ripgrep'
Plug 'nathanalderson/yang.vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nfvs/vim-perforce'

call plug#end()

" General vim config
set clipboard=unnamedplus
set number relativenumber
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
nmap <Leader>t  :terminal<CR>:file<Space>
autocmd TermOpen * setlocal nonumber norelativenumber
set spelllang=en
set spellfile=$HOME/.config/nvim/en.utf-8.add

" Get indents that actually make sense
filetype plugin indent on
set shiftwidth=4
set tabstop=4
set softtabstop=0
set expandtab
set smarttab
set autoindent
set smartindent
set scrolloff=3
set autoread

" LanguageClient-neovim config
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1

" vim-choosewin config
nmap <Leader>w <Plug>(choosewin)

" Command-T config
nmap <Leader>ff <Plug>(CommandT)
nmap <Leader>b <Plug>(CommandTBuffer)

" Color scheme
set t_Co=256
set background=light
colorscheme PaperColor

" ALE
let g:ale_sign_error = "!"
let g:ale_sign_warning = "-"
highlight ALEErrorSign ctermbg=red guibg=red
highlight ALEWarningSign ctermbg=yellow guibg=yellow

let g:ale_linters = {
\   'python': ['flake8', 'pylint', 'black', 'mypy'],
\}

" rst folding is annoying
let g:riv_disable_folding = 1
let g:riv_fold_level = 0
let g:riv_fold_auto_update = 0
let g:rst_syntax_folding = 0
let g:riv_auto_fold_force = 0
set nofoldenable



let g:netrw_dirhistmax=0
