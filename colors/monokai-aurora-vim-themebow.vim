hi clear
if version > 580
    if exists("syntax_on")
        syntax reset
    endif
endif

let colors_name="monokai-aurora"

if has("gui_running")
    set background=light
endif

hi Normal       guifg=#eeeeee   guibg=#152122   gui=NONE cterm=NONE
hi DiffAdd      guifg=#e12977    guibg=#152122   gui=NONE cterm=NONE
hi DiffChange   guifg=#eeeeee   guibg=#152122   gui=NONE cterm=NONE
hi DiffText     guifg=#eeeeee    guibg=#152122   gui=NONE cterm=NONE
hi DiffDelete   guifg=#eeeeee   guibg=#152122   gui=NONE cterm=NONE
hi Folded       guifg=#eeeeee   guibg=#152122   gui=NONE cterm=NONE
hi LineNr       guifg=#eeeeee   guibg=#152122   gui=NONE cterm=NONE
hi NonText      guifg=#eeeeee   guibg=#152122   gui=NONE cterm=NONE
hi VertSplit    guifg=#eeeeee   guibg=#eeeeee   gui=NONE cterm=NONE
hi StatusLine   guifg=#eeeeee   guibg=#152122   gui=BOLD cterm=BOLD
hi StatusLineNC guifg=#eeeeee   guibg=#152122   gui=ITALIC cterm=NONE
hi ModeMsg      guifg=#eeeeee    gui=NONE cterm=NONE
hi MoreMsg      guifg=#eeeeee    gui=NONE cterm=NONE
hi Title        guifg=#eeeeee  guibg=#152122   gui=NONE cterm=NONE
hi WarningMsg   guifg=#eeeeee   guibg=#152122  gui=NONE cterm=NONE
hi SpecialKey   guifg=#eeeeee guibg=#152122   gui=ITALIC cterm=NONE
hi MatchParen   guifg=#eeeeee   guibg=#152122   gui=NONE cterm=NONE
hi Underlined   guifg=#eeeeee   gui=UNDERLINE cterm=UNDERLINE
hi Directory    guifg=#686868    gui=NONE cterm=NONE
hi Visual       guifg=#eeeeee guibg=#152122     gui=NONE cterm=NONE
hi VisualNOS    guifg=#eeeeee guibg=#152122    gui=NONE cterm=NONE
hi IncSearch    guifg=#eeeeee   guibg=#152122   gui=ITALIC cterm=NONE
hi Search       guifg=#eeeeee   guibg=#152122   gui=ITALIC cterm=NONE
hi Ignore       guifg=#686868   gui=NONE cterm=NONE
hi Identifier   guifg=#eeeeee   guibg=#152122    gui=NONE cterm=NONE
hi PreProc      guifg=#eeeeee   gui=BOLD cterm=BOLD
hi Comment      guifg=#686868   gui=ITALIC cterm=NONE
hi Constant     guifg=#eeeeee    guibg=#152122    gui=NONE cterm=NONE
hi String       guifg=#E6DB74  guibg=#152122   gui=NONE cterm=NONE
hi Function     guifg=#eeeeee guibg=#152122    gui=BOLD cterm=BOLD
hi Statement    guifg=#eeeeee   gui=BOLD cterm=BOLD
hi Type         guifg=#eeeeee    gui=BOLD cterm=BOLD
hi Number       guifg=#50afe9   guibg=#152122    gui=NONE cterm=NONE
hi Todo         guifg=#eeeeee guibg=#152122   gui=BOLD cterm=BOLD
hi Special      guifg=#eeeeee    guibg=#152122    gui=BOLD cterm=BOLD
hi rubySymbol   guifg=#960B73    gui=NONE cterm=NONE
hi Error           guifg=#E6DB74 guibg=#1E0010
