
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-plug'

Plug 'lervag/vimtex', { 'for': 'tex' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'dense-analysis/ale'

Plug 'SirVer/ultisnips'

Plug 'honza/vim-snippets'

Plug 'Yggdroot/indentLine'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-unimpaired'

" Plug 'terryma/vim-multiple-cursors'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'

Plug 'drewtempelmeyer/palenight.vim'

"Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'vim-airline/vim-airline'

Plug 'ludovicchabant/vim-gutentags'

Plug 'rlue/vim-barbaric'

Plug 'whatyouhide/vim-tmux-syntax'

Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'jeetsukumaran/vim-pythonsense'

call plug#end()

filetype plugin indent on
syntax on

set encoding=utf-8
set ruler
set linespace=5
set tabstop=4 shiftwidth=4 expandtab
set conceallevel=2

nnoremap te :tabe
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap td :tabclose<CR>

"relative line number"
set number relativenumber
augroup numertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave *     set relativenumber
    autocmd BufEnter,FocusGained,InsertLeave *.tex set norelativenumber
    autocmd BufLeave,FocusLost,InsertEnter   *     set norelativenumber
augroup END

set spell
set spelllang=en_us
set background=dark
colorscheme palenight
"colorscheme dracula
let g:airline_theme = "palenight"
let g:palenight_terminal_italics=1
set termguicolors

let g:python_host_prog = expand('~/.virtualenvs/neovim2/bin/python')
let g:python3_host_prog = expand('~/.virtualenvs/neovim/bin/python')
let g:node_host_prog = expand('~/.nvm/versions/node/v13.5.0/bin/neovim-node-host')

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_progname = 'nvr'
let g:tex_conceal='abdmg'

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

let g:indentLine_fileTypeExclude = ['tex']

"key bindings for Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]

"Fugitive status line
set laststatus=2
"set statusline+=%{FugitiveStatusline()}

"coc settings
"
let g:coc_global_extensions = [
    \ 'coc-vimtex',
    \ 'coc-omni',
    \ 'coc-snippets',
    \ 'coc-python',
    \ 'coc-json',
    \ 'coc-yaml',
    \]
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"ale settings
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_delay = 0
let g:ale_fix_on_save = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'

let g:ale_statusline_format = ['Errors: %d', 'Warnings: %d', '']

let g:ale_linters = {
\   'tex': [],
\   'python': ['flake8', 'mypy', 'pylint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['reorder-python-imports'],
\}

let g:airline#extensions#ale#enables = 1

nmap <silent> <leader>ak <Plug>(ale_previous_wrap)
nmap <silent> <leader>aj <Plug>(ale_next_wrap)
nmap <silent> <leader>ao :lw<CR>
