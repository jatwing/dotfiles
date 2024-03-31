vim.cmd("set cc=80")
vim.cmd("set expandtab")
vim.cmd("set number")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set tabstop=4")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
      "williamboman/mason.nvim",
     "williamboman/mason-lspconfig.nvim",
     "neovim/nvim-lspconfig",
     'preservim/nerdtree',
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
    "github/copilot.vim",
    'neovim/nvim-lspconfig',
    -- nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip'
}
local opts = {}

require("lazy").setup(plugins, opts)

vim.cmd.colorscheme "tokyonight"

 require("mason").setup()
 require("mason-lspconfig").setup {
     ensure_installed = {
         "cssls",
         "html",
         "tsserver",
         "sqlls",
         "volar"
     },
 }


 require('lspconfig').tsserver.setup{
   init_options = {
     plugins = {
       {
         name = "@vue/typescript-plugin",
         location = "~/.nvm/versions/node/v20.11.1/lib/node_modules/@vue/typescript-plugin",
         languages = {"javascript", "typescript", "vue"},
       },
     },
   },
     filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'json'},
 }


 require('lspconfig').volar.setup{
   init_options = {
     typescript = {
       tsdk = "~/.nvm/versions/node/v20.11.1/lib/node_modules/typescript/lib"
       -- Alternative location if installed as root:
       -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
     }
   },
   filetypes = {'vue'},
    -- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
 }

 vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, { buffer = args.buf })
 end,
 })





-- nvim-cmp

-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }





-- "preservim/nerdtree
vim.keymap.set('n', '<C-c>', ':NERDTreeClose<CR>')
vim.keymap.set('n', '<C-f>', ':NERDTreeFocus<CR>')
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')
