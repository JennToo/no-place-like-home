local home = os.getenv("HOME")

if vim.fn.filereadable(home .. "/.virtualenvs/neovim-py3/bin/python") ~= 0
then
    vim.g.python3_host_prog = home .. "/.virtualenvs/neovim-py3/bin/python"
end

vim.g.send_disable_mapping = true

if vim.fn.filereadable(home .. "/.config/nvim/autoload/plug.vim") ~= 0
then
    local Plug = vim.fn['plug#']
    vim.call("plug#begin", '~/.local/share/nvim/plugged')

    Plug('neovim/nvim-lspconfig')
    Plug('hrsh7th/cmp-nvim-lsp')
    Plug('hrsh7th/cmp-buffer')
    Plug('hrsh7th/cmp-path')
    Plug('hrsh7th/cmp-cmdline')
    Plug('hrsh7th/nvim-cmp')
    Plug('hrsh7th/cmp-vsnip')
    Plug('hrsh7th/vim-vsnip')
    Plug('andersevenrud/cmp-tmux')

    Plug('roxma/nvim-yarp')
    Plug('mfussenegger/nvim-lint')
    Plug(
        'junegunn/fzf',
        {
            ['do'] = function()
                vim.fn['fzf#install']()
            end
        }
    )
    Plug('junegunn/fzf.vim')
    Plug('lukas-reineke/indent-blankline.nvim')
    Plug('rose-pine/neovim')
    Plug('nvim-lua/plenary.nvim')
    Plug('junegunn/vim-easy-align')
    Plug('dknaack/qf-diagnostics.nvim')
    Plug('mtikekar/nvim-send-to-term')
    Plug('gpanders/nvim-parinfer')
    Plug('samsaga2/vim-z80')

    Plug(
        'nvim-treesitter/nvim-treesitter',
        {
            ['do'] = function()
                vim.fn['TSUpdate']()
            end
        }
    )

    vim.call('plug#end')
end

local project_name = vim.fs.basename(vim.fn.getcwd())
pcall(require, "projects/" .. project_name)

vim.opt.termguicolors = true
vim.opt.clipboard= "unnamedplus"
vim.opt.spelllang="en"
vim.opt.spellfile=home .."/.config/nvim/en.utf-8.add"
vim.opt.cursorline = true

vim.opt.makeprg = "quickfix-parser /tmp/last-build.log"
vim.opt.errorformat = "type %t file %f line %l col %c message %m"

vim.opt.list = true
vim.opt.listchars="tab:\\u2192 ,trail:\\u2592"

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = "*",
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})

-- Get indents that actually make sense
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scrolloff = 3
vim.opt.autoread = true

local opts = { noremap=true }
vim.keymap.set('v', '<C-r>', '"hy:%s#<C-r>h##gc<left><left><left>', opts)
vim.keymap.set('v', '<C-w>', '"hy:%s#\\<<C-r>h\\>##gc<left><left><left>', opts)
vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)', opts)
vim.keymap.set('i', '<C-l>', 'λ', opts)
vim.keymap.set('n', '<Leader>ff', ':Files<Cr>', opts)
vim.keymap.set('n', '<Leader>bb', ':Buffers<Cr>', opts)
vim.keymap.set('n', '<Leader>bf', vim.lsp.buf.format, opts)
vim.keymap.set('n', '<Leader>st', 'mavip:w !tmux-sender REPL<Cr><Cr>`a', opts)
vim.keymap.set('v', '<Leader>ss', ':w !tmux-sender REPL<Cr><Cr>', opts)
vim.keymap.set('n', '<Leader>ws', '"hyiw:Rg <C-r>h<Cr>', opts)
vim.keymap.set('n', '<Leader>wc', '"z20<Cr>', opts)
vim.keymap.set('n', '<C-n>', ':cn<Cr>', opts)
vim.keymap.set('n', '<C-p>', ':cp<Cr>', opts)
vim.keymap.set('n', '<Leader>cc', ':make<Cr><Cr>:copen<Cr>', opts)
vim.keymap.set('n', '<Leader>ce', ':make -l e<Cr><Cr>:copen<Cr>', opts)
vim.keymap.set('n', '<Leader>cq', ':cclose<Cr>', opts)
vim.keymap.set('n', '<Leader>dd', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, opts)

-- The defaults replace 's', which is no good
vim.keymap.set('n', 'S', '<Plug>Send')
vim.keymap.set('v', 'S', '<Plug>Send')

-- Navigation keys
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', opts)
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l', opts)
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)

vim.o.background = "light"
require('rose-pine').setup({
    highlight_groups = {
		StatusLine = { fg = 'pine', bg = 'pine', blend = 20 },
		StatusLineNC = { fg = 'pine' },
    }
})
vim.cmd.colorscheme('rose-pine')

-- rst folding is annoying
vim.g.riv_disable_folding = 1
vim.g.riv_fold_level = 0
vim.g.riv_fold_auto_update = 0
vim.g.rst_syntax_folding = 0
vim.g.riv_auto_fold_force = 0
vim.opt.foldenable = false

vim.opt.wildignore = {
    '*/.ccls-cache/*',
    '*/.ezdebugger/*',
    '*.o',
    '*.d',
    '*.class',
    '*.jar',
    '*.pyc'
}

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.s', '*.S', '*.a65'},
    callback = function()
        vim.opt.filetype = 'asm_ca65'
    end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.zuo'},
    callback = function()
        vim.opt.filetype = 'racket'
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'gitcommit', 'markdown', 'rst'},
    callback = function()
        vim.opt_local.spell = true
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'vhdl'},
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'json'},
    callback = function()
        vim.opt_local.formatprg = 'jq'
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'groovy', 'Jenkinsfile'},
    callback = function()
        vim.bo.commentstring = '//%s'
    end
})

vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
    pattern = {'*'},
    callback = function()
        vim.cmd.checktime()
    end
})

local lspconfig = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'tmux' },
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert,preview',
    },
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
-- The manual says these are on by default, but they don't seem to be
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)

local servers = { 'clangd', 'rust_analyzer', 'pylsp', 'vhdl_ls' }
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, lsp in ipairs(servers) do
  vim.lsp.config (lsp, {
      capabilities = capabilities
  })
  vim.lsp.enable(lsp)
end

vim.cmd [[highlight IndentBlanklineIndent1 guibg=#E4EEEE gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#F9E9E5 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guibg=#FAF5EF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guibg=#F9E9E5 gui=nocombine]]

vim.cmd [[
    let g:vsnip_snippet_dirs = ["/home/jwilcox/.vsnip-local/"]
    imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]]

require("ibl").setup {
    indent = {
        char = "",
        highlight = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
        }
    },
    whitespace = {
        remove_blankline_trail = false,
        highlight = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
        }
    },
}
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "css",
      "diff",
      "dockerfile",
      "gitignore",
      "groovy",
      "html",
      "json",
      "json5",
      "jsonc",
      "lua",
      "make",
      "nginx",
      "pem",
      "powershell",
      "python",
      "rst",
      "rust",
      "scss",
      "sql",
      "tcl",
      "toml",
      "verilog",
      "vhdl",
      "vimdoc",
      "xml",
      "yaml",
      "yang",
  },
  auto_install = false,
  highlight = {
    enable = true,
  },
}

require('lint').linters_by_ft = {
  sh = {'shellcheck'},
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

require("qf-diagnostics").setup()

vim.diagnostic.config({
    virtual_lines = true
})
