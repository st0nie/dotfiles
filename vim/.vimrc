call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'NLKNguyen/papercolor-theme'
Plug 'jnurmine/Zenburn'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stillwwater/wincap.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'romainl/vim-cool'
" Plug 'vim-scripts/zoom.vim'
Plug 'mg979/vim-visual-multi'
Plug 'st0nie/copilot.vim'
Plug 'markonm/traces.vim'
Plug 'lilydjwg/fcitx.vim'

call plug#end()

let mapleader = ","

" Coc START
" https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Map <tab> for trigger completion, completion confirm, snippet expand and jump, jump outside closing bracket or other pairs of symbols like VSCode

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ NextCharIsPair() ? "\<Right>" :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(0) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(0) : "\<C-k>"

function! CheckBackspace() abort
  let col = col('.') - 1 
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! NextCharIsPair() abort
  let col = col('.') - 1 
  let l:next_char = getline('.')[col]
  return l:next_char =~# ')\|]\|}\|>\|''\|"\|`'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd User visual_multi_mappings imap <buffer><expr> <CR> coc#pum#visible() ? coc#pum#confirm() 
      \: "\<Plug>(VM-I-Return)"
autocmd User visual_multi_mappings imap <buffer><expr> <Up> coc#pum#visible() ? coc#pum#prev(0)
      \: "\<Up>"
autocmd User visual_multi_mappings imap <buffer><expr> <Down> coc#pum#visible() ? coc#pum#next(0)
      \: "\<Down>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
" if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
" else
" inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <M-i> <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Show files in workspace
nnoremap <silent><nowait> <space>f  :<C-u>CocList files<cr>
nnoremap <silent><nowait> <space>b  :<C-u>CocList buffers<cr>

" Coc END

set background=light
colorscheme zenburn

set backspace=indent,eol,start

set nocompatible

set relativenumber
set number

set cursorline

set termguicolors

set hlsearch

set autochdir

nnoremap Y y$
noremap <space>y "+y

noremap <F2> <Plug>(coc-rename)
noremap <F4> :Format<CR>

set wildmenu
set wildoptions=pum
set wildmode=longest:full,full

nmap <leader>e <Cmd>CocCommand explorer<CR>

nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>

autocmd User CocGitStatusChange call s:update_git_status()

" set iminsert=2
set hidden

let g:airline_powerline_fonts = 1

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '|'
let g:airline_right_alt_sep = '|'

let g:coc_global_extensions = ['coc-json', 'coc-lists', 'coc-snippets', 'coc-pairs', 'coc-marketplace', 'coc-highlight', 'coc-git', 'coc-explorer']

set ts=4 sw=4

command! -nargs=0 MarkdownPreview   :call     CocActionAsync('runCommand', 'markdown-preview-enhanced.openPreview')

" disable welcome message
set shortmess+=I

set ttimeoutlen=10

" right bottom show pressed keys
set showcmd

let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

set tabstop=4
set shiftwidth=4
set mouse=a

set fileencodings=ucs-bom,utf-8,gb2312,default

if !isdirectory(expand("~/.vim/swap"))
    call mkdir(expand("~/.vim/swap"), "p")
endif

set directory=~/.vim/swap/
