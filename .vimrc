set cc=80
set expandtab
set number
set shiftwidth=4
set softtabstop=4
set tabstop=4
syntax on

"Return to last edit position when opening files (You want this!)
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
"Plug 'prettier/vim-prettier', { 'do': 'npm install' }
call plug#end()

"morhetz/gruvbox
colorscheme gruvbox
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox

"neoclide/coc.nvim
"nnoremap <C-h> :call CocAction('doHover')<CR>
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"preservim/nerdtree
let NERDTreeShowHidden=1
nnoremap <C-c> :NERDTreeClose<CR>
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-h> :call CocAction('doHover')<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

"prettier/vim-prettier
"packloadal
":command P Prettier
