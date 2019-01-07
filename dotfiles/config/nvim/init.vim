call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'roxma/nvim-yarp'
Plug 't9md/vim-choosewin'
Plug 'flazz/vim-colorschemes'
Plug 'jremmen/vim-ripgrep'
Plug 'nathanalderson/yang.vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" General vim config
set clipboard=unnamedplus
set number relativenumber
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
nmap <Leader>t  :terminal<CR>:file<Space>
autocmd TermOpen * setlocal nonumber norelativenumber

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

" Do the splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
