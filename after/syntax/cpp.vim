" Document comment highlight for C/CPP
" Origin from rust.vim
" Language:     C/CPP
" Author:       Zhiwei Chen
" Url:          https://github.com/condy0919/docom.vim

" Keyword definitions
syn keyword docomConditional if else switch
syn keyword docomStatement   goto break return continue asm
syn keyword docomStatement   new delete this friend using
syn keyword docomLabel       case default
syn keyword docomOperator    sizeof alignof operator typeid
syn keyword docomExceptions  try throw catch

syn keyword docomConstant __FUNCTION__ __PRETTY_FUNCTION__ __func_
syn keyword docomConstant __LINE__ __FILE__ __DATE__ __TIME__
syn keyword docomConstant __VA_ARGS__
syn keyword docomConstant true false

syn keyword docomType bool char short int long void
syn keyword docomType signed unsigned float double
syn keyword docomType size_t ssize_t ptrdiff_t
syn keyword docomType clock_t time_t va_list jmp_buf FILE DIR
syn keyword docomType char16_t char32_t
syn keyword docomType int8_t int16_t int32_t int64_t
syn keyword docomType uint8_t uint16_t uint32_t uint64_t
syn keyword docomType int_least8_t int_least16_t int_least32_t int_least64_t
syn keyword docomType uint_least8_t uint_least16_t uint_least32_t uint_least64_t
syn keyword docomType int_fast8_t int_fast16_t int_fast32_t int_fast64_t
syn keyword docomType uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
syn keyword docomType intptr_t uintptr_t
syn keyword docomType intmax_t uintmax_t
syn keyword docomType nullptr_t auto

syn keyword docomStructure struct class typename template union enum
syn keyword docomStructure typedef template namespace

syn keyword docomStorage static register auto volatile extern const
syn keyword docomStorage inline thread_local alignas mutable
syn keyword docomStorage constexpr decltype

syn keyword docomModifier virtual explicit override final
syn keyword docomAccess   public protected private
syn keyword docomCast     const_cast static_cast dynamic_cast reinterpret_cast

syn keyword docomTodo contained TODO FIXME XXX NOTE NB

" Region definitions
syn region docomCommentLine                                                   start="//"                      end="$"   contains=docomTodo,@Spell
syn region docomCommentLineDoc                                                start="//\%(//\@!\|!\)"         end="$"   contains=@Spell
syn region docomCommentBlock             matchgroup=docomCommentBlock         start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=@Spell
syn region docomCommentBlockDoc          matchgroup=docomCommentBlockDoc      start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=docomCommentBlockDocCode,@Spell

" Highlight code within ```
if !exists("b:current_syntax_embed")
  let b:current_syntax_embed = 1
  syntax include @CodeInComment syntax/cpp.vim
  unlet b:current_syntax_embed

  " Currently regions marked as ```<some-other-syntax> will not get
  " highlighted at all. In the future, we can do as vim-markdown does and
  " highlight with the other syntax. But for now, let's make sure we find
  " the closing block marker, because the rules below won't catch it.
  syn region docomCommentLinesDocNonCode matchgroup=docomCommentDocCodeFence start='^\z(\s*//[!/]\s*```\).\+$' end='^\z1$' keepend contains=docomCommentLineDoc

  syn region docomCommentLinesDocCode matchgroup=docomCommentDocCodeFence start='^\z(\s*//[!/]\s*```\)[^A-Za-z0-9_-]*\%([^A-Za-z0-9_-]\+\|$\)*$' end='^\z1$' keepend contains=@CodeInComment,docomCommentLineDocLeader
  syn region docomCommentBlockDocCode matchgroup=docomCommentDocCodeFence start='^\z(\%(\s*\*\)\?\s*```\)[^A-Za-z0-9_-]*\%([^A-Za-z0-9_-]\+\|$\)*$' end='^\z1$' keepend contains=@CodeInComment,docomCommentBlockDocStar
  " Strictly, this may or may not be correct; this code, for example, would
  " mishighlight:
  "
  "     /**
  "     ```
  "     printf("%d\n", 1
  "       * 1);
  "     ```
  "     */
  "
  " … but I don’t care. Balance of probability, and all that.
  syn match docomCommentBlockDocStar /^\s*\*\s\?/ contained
  syn match docomCommentLineDocLeader "^\s*//\%(//\@!\|!\)" contained
endif

hi def link docomConditional Conditional
hi def link docomStatement   Statement
hi def link docomConstant    Constant
hi def link docomOperator    Operator
hi def link docomLabel       Label

hi def link docomType      Type
hi def link docomStorage   StorageClass
hi def link docomStructure Structure

hi def link docomAccess     Statement
hi def link docomExceptions Exception
hi def link docomModifier   Type
hi def link docomCast       Statement

hi def link docomTodo Todo

hi def link docomCommentLine   Comment
hi def link docomCommentLineDoc SpecialComment
hi def link docomCommentLineDocLeader docomCommentLineDoc
hi def link docomCommentBlock  docomCommentLine
hi def link docomCommentBlockDoc docomCommentLineDoc
hi def link docomCommentBlockDocStar docomCommentBlockDoc
hi def link docomCommentDocCodeFence docomCommentLineDoc

" Force vim to sync at least 100 lines
syn sync minlines=100

" vim: set et sw=2 sts=2 ts=2:
