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
    "github/copilot.vim"
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
 }
 
 
 require('lspconfig').volar.setup{
   init_options = {
     typescript = {
       tsdk = "~/.nvm/versions/node/v20.11.1/lib/node_modules/typescript/lib"
       -- Alternative location if installed as root:
       -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
     }
   },
     filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
 }
 
 vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, { buffer = args.buf })
 end,
 })

--require("nvim-tree").setup({
--    on_attach = my_on_attach,
-- })




-- "preservim/nerdtree
vim.keymap.set('n', '<C-c>', ':NERDTreeClose<CR>')
vim.keymap.set('n', '<C-f>', ':NERDTreeFocus<CR>')
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')
