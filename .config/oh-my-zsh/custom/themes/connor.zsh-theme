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
plus_minus_glyph=' '
user_glyph=''
left_half_circle_glyph=''
right_half_circle_glyph=''

local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color$white_foreground%}on %{$green_foreground%}$left_half_circle_glyph%{$black_foreground$green_background%}$git_branch_glyph "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color$green_foreground%}$right_half_circle_glyph%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" $plus_minus_glyph"

PROMPT="\
%{$cyan_foreground%}$left_half_circle_glyph%{$black_foreground$cyan_background%}$user_glyph %n%{$reset_color$cyan_foreground%}$right_half_circle_glyph \
%{$reset_color$white_foreground%}in%{%f%} \
%{$yellow_foreground%}$left_half_circle_glyph%{$yellow_background$black_foreground%}$directory_glyph %~%{$reset_color$yellow_foreground%}$right_half_circle_glyph\
${git_info}
%{$red_foreground%}%(?..[%?] )%{$reset_color%}%{$magenta_foreground%}$%{%f%} "
