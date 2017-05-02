function! manipulist#undo() abort
  let wininfo = get(getwininfo(win_getid()), 0)
  if !get(wininfo, 'quickfix')
    echoerr '[manipulist] manipulist#undo() requires to be called on a quickfix/location-list window'
    return 1
  endif
  if wininfo.loclist
    return s:undo_ll()
  else
    return s:undo_qf()
  endif
endfunction

function! manipulist#remove() abort range
  let wininfo = get(getwininfo(win_getid()), 0)
  if !get(wininfo, 'quickfix')
    echoerr '[manipulist] manipulist#remove() requires to be called on a quickfix/location-list window'
    return 1
  endif
  if wininfo.loclist
    return s:remove_ll(a:firstline, a:lastline)
  else
    return s:remove_qf(a:firstline, a:lastline)
  endif
endfunction


" Private --------------------------------------------------------------------
function! s:undo_ll() abort
  let history = get(w:, 'll_history', [])
  if !empty(history)
    call setloclist(0, remove(history, -1), 'r')
  endif
endfunction

function! s:undo_qf() abort
  let history = get(w:, 'qf_history', [])
  if !empty(history)
    call setloclist(remove(history, -1), 'r')
  endif
endfunction

function! s:remove_qf(fline, lline) abort
  let candidates = getqflist()
  let w:qf_history = get(w:, 'qf_history', [])
  call add(w:qf_history, copy(candidates))
  unlet! candidates[a:fline-1 : a:lline-1]
  call setqflist(candidates, 'r')
  execute a:fline
endfunction

function! s:remove_ll(fline, lline) abort
  let candidates = getloclist(0)
  let w:ll_history = get(w:, 'll_history', [])
  call add(w:ll_history, copy(candidates))
  unlet! candidates[a:fline-1 : a:lline-1]
  call setloclist(0, candidates, 'r')
  execute a:fline
endfunction
