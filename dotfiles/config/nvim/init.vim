let g:python3_host_prog = "/home/jwilcox/.virtualenvs/neovim-py3/bin/python"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'roxma/nvim-yarp'
Plug 'flazz/vim-colorschemes'
Plug 'nathanalderson/yang.vim'
Plug 'w0rp/ale'
Plug 'nfvs/vim-perforce'
Plug 'ARM9/arm-syntax-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'vim-scripts/groovyindent-unix'
Plug 'tjvr/vim-nearley'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'maxbane/vim-asm_ca65'

call plug#end()


" General vim config
set clipboard=unnamedplus
set number
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
nmap <Leader>t  :terminal<CR>:file<Space>
autocmd TermOpen * setlocal nonumber norelativenumber
set spelllang=en
set spellfile=$HOME/.config/nvim/en.utf-8.add
vnoremap <C-r> "hy:%s#<C-r>h##gc<left><left><left>
set cursorline

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

nnoremap <Leader>ff :Files<Cr>
nnoremap <Leader>b :Buffers<Cr>

" Color scheme
set background=light
try
    colorscheme PaperColor
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
endtry

" ALE
let g:ale_sign_error = "!"
let g:ale_sign_warning = "-"
highlight ALEErrorSign ctermbg=red guibg=red
highlight ALEWarningSign ctermbg=yellow guibg=yellow
let g:ale_asm_gcc_executable = "arm-none-eabi-gcc"

let g:ale_linters = {
\   'cpp': [],
\   'haskell': ['stack-build'],
\   'python': ['pylama'],
\}

" rst folding is annoying
let g:riv_disable_folding = 1
let g:riv_fold_level = 0
let g:riv_fold_auto_update = 0
let g:rst_syntax_folding = 0
let g:riv_auto_fold_force = 0
set nofoldenable

set wildignore=*/.ccls-cache/*,*/.ezdebugger/*,*.o,*.d,*.class,*.jar,*.pyc

let g:netrw_dirhistmax = 0

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
au BufNewFile,BufRead *.a65 set ft=asm_ca65
au BufNewFile,BufRead *.md,*.rst setlocal spell
autocmd FileType gitcommit setlocal spell

let g:LanguageClient_serverCommands = {
    \ 'scala': ['metals-vim'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:LanguageClient_useVirtualText = 'No'
let g:LanguageClient_loggingLevel = 'DEBUG'

let g:deoplete#enable_at_startup = 1
autocmd CompleteDone * silent! pclose!
let g:deoplete#sources#jedi#ignore_private_members = 1

let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 0

let g:indent_guides_enable_on_vim_startup = 1
