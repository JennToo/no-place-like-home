call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'roxma/nvim-yarp'
Plug 'flazz/vim-colorschemes'
Plug 'jremmen/vim-ripgrep'
Plug 'nathanalderson/yang.vim'
Plug 'w0rp/ale'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nfvs/vim-perforce'
Plug 'ARM9/arm-syntax-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

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

" Command-T config
nmap <Leader>ff <Plug>(CommandT)
nmap <Leader>b <Plug>(CommandTBuffer)
nmap <C-]> <Plug>(ale_go_to_definition)

" Color scheme
set t_Co=256
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
\   'cpp': ['ccls'],
\   'haskell': ['stack-build'],
\   'python': ['pylama'],
\   'vhdl': ['vunit'],
\}

" rst folding is annoying
let g:riv_disable_folding = 1
let g:riv_fold_level = 0
let g:riv_fold_auto_update = 0
let g:rst_syntax_folding = 0
let g:riv_auto_fold_force = 0
set nofoldenable

set wildignore=*/.ccls-cache/*,*/.ezdebugger/*,*.o,*.d,*.class,*.jar,*.pyc
let g:CommandTMaxFiles=200000

let g:netrw_dirhistmax=0

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

au BufNewFile,BufRead *.md,*.rst setlocal spell


let g:LanguageClient_serverCommands = {
    \ 'scala': ['metals-vim'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:LanguageClient_useVirtualText=0
let g:deoplete#enable_at_startup = 1

function! GetVunitCommand(buffer) abort
    let l:vunit_path = ale#path#FindNearestFile(a:buffer, 'vunit')
    let l:project_root = fnamemodify(l:vunit_path, ':h')
    let l:cd_string = l:project_root isnot# ''
    \   ? ale#path#CdString(l:project_root)
    \   : ale#path#BufferCdString(a:buffer)

    return l:cd_string
    \      . "./vunit --compile"
endfunction

call ale#linter#Define('vhdl', {
\   'name': 'vunit',
\   'output_stream': 'stdout',
\   'executable': './vunit',
\   'command': function('GetVunitCommand'),
\   'callback': 'ale_linters#vhdl#ghdl#Handle',
\})
