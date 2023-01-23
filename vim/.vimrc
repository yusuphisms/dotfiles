let g:gruvbox_transparent_bg = 1
let g:gruvbox_termcolors = 16
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_contrast_dark = 'hard'

colorscheme gruvbox

syntax enable
filetype plugin indent on

" Change indentation spacing
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set nu

" Change swap file location
set dir=$HOME/.vim/tmp/swap
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif

" Set background color for the popup menu
highlight Pmenu ctermbg=0 ctermfg=7
highlight PmenuSel ctermbg=2


let g:rust_clip_command = 'xclip -selection clipboard'

" ALE configurations
let g:ale_completion_enabled = 0
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
                \   'name': 'rust-analyzer',
                \   'cmd': {server_info->['rust-analyzer']},
                \   'whitelist': ['rust'],
                \   'initialization_options': {
                \       'checkOnSave': { 'command': 'clippy', 'enable': v:true },
                \   },
                \ })
endif

" Tab Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Other random shortcuts
set clipboard=unnamedplus
nmap <buffer> <leader><Tab> <Esc>:tabNext<CR> 

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=number
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>? <plug>(lsp-document-diagnostics)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>a <plug>(lsp-code-action)
    nnoremap <buffer> <expr><c-j> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-k> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go,*.tsx,*.js call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" Debugging vim-lsp
let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" Markdown syntax highlighting beyond built-in
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END 
