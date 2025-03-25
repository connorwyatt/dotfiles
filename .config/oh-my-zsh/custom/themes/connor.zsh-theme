red_foreground="%F{red}"
red_background="%K{red}"
yellow_foreground="%F{yellow}"
yellow_background="%K{yellow}"
green_foreground="%F{green}"
green_background="%K{green}"
cyan_foreground="%F{cyan}"
cyan_background="%K{cyan}"
blue_foreground="%F{blue}"
blue_background="%K{blue}"
magenta_foreground="%F{magenta}"
magenta_background="%K{magenta}"
white_foreground="%F{white}"
white_background="%K{white}"
black_foreground="%F{black}"
black_background="%K{black}"

git_branch_glyph=''
directory_glyph='󰉋'
plus_minus_glyph=''
user_glyph=''

local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$white_foreground%}on%{%f%} %{$red_foreground%}$git_branch_glyph "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$cyan_foreground%}$plus_minus_glyph"

PROMPT="\
%{$magenta_foreground%}$user_glyph %n\
 %{$white_foreground%}in%{%f%} \
%{$yellow_foreground%}$directory_glyph %~\
%{$git_info%}
%{$red_foreground%}%(?..[%?] )%{$green_foreground%}$%{%f%} "
