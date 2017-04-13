if exists('b:manipulist_loaded')
  finish
endif
let b:manipulist_loaded = 1

nnoremap <silent><buffer> <Plug>(manipulist-preview) <CR>zz<C-w>p
nnoremap <silent><buffer> <Plug>(manipulist-undo)   :<C-u>call manipulist#undo()<CR>
nnoremap <silent><buffer> <Plug>(manipulist-remove) :<C-u>call manipulist#remove()<CR>
vnoremap <silent><buffer> <Plug>(manipulist-remove) :<C-u>'<,'>call manipulist#remove()<CR>

if get(g:, 'manipulist_default_mappings', 1)
  nmap <buffer> p  <Plug>(manipulist-preview)
  nmap <buffer> u  <Plug>(manipulist-undo)
  nmap <buffer> dd <Plug>(manipulist-remove)
  vmap <buffer> dd <Plug>(manipulist-remove)
endif
