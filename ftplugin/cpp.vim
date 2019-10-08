if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://,:///,://!

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set et sw=2 sts=2 ts=2:
