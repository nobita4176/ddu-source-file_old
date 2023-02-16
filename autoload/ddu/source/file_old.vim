function! ddu#source#file_old#_get_oldfiles() abort
  let l:oldfiles = v:oldfiles->copy()->map(
        \ { _, val -> val->substitute('^\~', '\=$HOME', '') })->filter(
        \ { _, val -> val->filereadable()
        \             && val->fnamemodify(':t') !=# 'COMMIT_EDITMSG' })

  if (has('win32'))
    if (&shellslash)
      let l:oldfiles = l:oldfiles->map({ _, val -> substitute(val, '\\', '/', 'g') })
    else
      let l:oldfiles = l:oldfiles->map({ _, val -> substitute(val, '/', '\\', 'g') })
    endif
  endif

  let l:oldfiles = l:oldfiles->filter({ _, val -> filereadable(val) })
  return l:oldfiles
endfunction
