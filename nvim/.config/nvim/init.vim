" True color
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'tshirtman/vim-cython'
Plug 'othree/html5.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-gitgutter'
call plug#end()

" Disable mouse (stops me messing up when I hit the touchpad while typing)
set mouse=""

" Shows where 80 chars is
set colorcolumn=80

" Switch syntax highlighting on
set background=dark
syntax enable
colorscheme gruvbox

" Default background (used for when I boot into transparent mode)
highlight Normal guibg=none
highlight NonText guibg=none

set backup             " keep a backup file (restore to previous version)
set undofile           " keep an undo file (undo changes after closing)
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set number             " show line numbers
set cursorline         " highlight current line
set wildmenu           " visual autocomplete
set lazyredraw         " only redraw when required
set showmatch          " show matching brackets
set incsearch          " dont need to use enter
set hlsearch           " highlights search matches
set splitbelow         " More natural horizontal splitting
set splitright         " More natural vertical splitting
set relativenumber     " Relative line numbers
set smartindent        " WHY WASN'T THIS HERE EARLIER? - Sincerely, past Lewis

" Puts vim files in ~/vimtmp instead of polluting every directory I touch
set backupdir=~/vimtmp,.
set directory=~/vimtmp,.

" Highlights cursorline
highlight cursorline guibg=#515151

" Custom colours for svn diff
highlight diffAdded guibg=#ddffdd
highlight diffRemoved guibg=#ffdddd
highlight diffFile guibg=#00ff00

" Opens `svn diff` (with the colors above)
if !exists(":SvnDiff")
  command SvnDiff :set syntax=diff | :r !svn diff
endif

" :W -> :w
if !exists(":W")
  command W :w
endif

" Don't use Ex mode, use Q for formatting
noremap Q gq

"Easy window split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

"Easy tab navigation
map <M-h> gT
map <M-l> gt
map <M-n> :tabe<cr>

" Move correctly when wrapping text
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

" Allow otherway
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

" Leader mapping
nnoremap <Space> <Nop>
let mapleader=' '

" Fast save
noremap <Leader>w :w<CR>

" Clear search highlighting
noremap <Leader>c :nohlsearch<CR>

" Fast navigation in html tags
noremap <Leader>, F<
noremap <leader>. f>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'textwidth' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif

" Highlight current line on active window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" Easier to open and edit init.vim
if !exists(":EditInit")
  command EditInit :e ~/.config/nvim/init.vim
endif

" Deoplete
let g:deoplete#enable_at_startup = 1
" Tab and Shift-Tab to navigate. Shift-Tab will also inverse tab if not using
" deoplete
inoremap <silent><expr> <Tab> pumvisible() ? "<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "<C-p>" : "\<C-d>"
set completeopt+=noinsert

" NERDTree
map <C-n> :NERDTreeToggle<cr>

" CtrlP
set wildignore+=*.pyc
set wildignore+=*~

" Don't move cursor after stuff with visual
vmap y ygv<Esc>
vmap Y Ygv<Esc>
vmap > >gv<Esc>
vmap < <gv<Esc>

" Select all
nnoremap <Leader>a ggvG$

" Powerline fonts
set guifont=Roboto\ Mono\ for\ Powerline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Cython syntax highlighting
au BufNewFile,BufRead *.pyd setfiletype pyrex
au BufNewFile,BufRead *.pyx setfiletype pyrex

" Torch syntax highlighting
au BufNewFile,BufRead *.th setfiletype lua

" Python stubs syntax highlighting
au BufNewFile,BufRead *.pyi setfiletype python

" TeX commands
function! TeX()
  " Placeholder
  " Should probs put stuff here
endfunction

autocmd Filetype tex call TeX()
