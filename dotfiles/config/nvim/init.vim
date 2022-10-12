let g:python3_host_prog = "/home/jwilcox/.virtualenvs/neovim-py3/bin/python"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'sheerun/vim-polyglot'
Plug 'roxma/nvim-yarp'
Plug 'flazz/vim-colorschemes'
Plug 'nathanalderson/yang.vim'
Plug 'w0rp/ale'
Plug 'Nitori-/vim-groovy'
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
\   'python': [],
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

au BufNewFile,BufRead *.s,*.S set filetype=asm_ca65
au BufNewFile,BufRead *.a65 set ft=asm_ca65
au BufNewFile,BufRead *.md,*.rst setlocal spell
autocmd FileType gitcommit setlocal spell
au BufNewFile,BufRead *.FCMacro set ft=python

let g:indent_guides_enable_on_vim_startup = 1

lua <<EOF
local lspconfig = require('lspconfig')

vim.g.coq_settings = {
    auto_start = 'shut-up',
    clients = {
        snippets = {
            warn = {}
        }
    }
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

local servers = { 'clangd', 'rust_analyzer', 'pyright' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({}))
end
EOF
