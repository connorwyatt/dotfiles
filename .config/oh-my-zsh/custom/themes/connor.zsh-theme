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

git_branch_glyph=$'\uf418'
directory_glyph=$'\uf413'
plus_minus_glyph=$'\ub1'
user_glyph=$'\uf2c0'
left_half_circle_glyph=$'\u25d6'
right_half_circle_glyph=$'\u25d7'

# Foreground Colors

local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$white_foreground%}on%{%f%} %{$green_foreground%}$git_branch_glyph "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$yellow_foreground%}$plus_minus_glyph%{%f%}"

#PROMPT="\
#%{$blue_foreground%}$user_glyph  %n%{%f%}@%{$magenta_foreground%}%m%{%f%}\
# %{$white_foreground%}in%{%f%} \
#%{$yellow_foreground%}$directory_glyph  %~%{$reset_color%}%{%f%}\
#${git_info}
#%{$magenta_foreground%}$%{%f%} "

PROMPT="\
%{$blue_foreground%}%n%{%f%}\
 %{$white_foreground%}in%{%f%} \
%{$yellow_foreground%}$directory_glyph  %~%{$reset_color%}%{%f%}\
${git_info}
%{$magenta_foreground%}$%{%f%} "

# Background Colors

#local git_info='$(git_prompt_info)'
#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color$white_foreground%}on %{$green_foreground%}$left_half_circle_glyph%{$black_foreground$green_background%} $git_branch_glyph  "
#ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color$green_foreground%}$right_half_circle_glyph%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY=" $plus_minus_glyph"
#
#PROMPT="\
#%{$blue_foreground%}$left_half_circle_glyph%{$black_foreground$blue_background%} $user_glyph  %n %{$blue_foreground$magenta_background%}$right_half_circle_glyph\
# %{$black_foreground%}%m %{$reset_color$magenta_foreground%}$right_half_circle_glyph\
# %{$reset_color$white_foreground%}in%{%f%}\
# %{$yellow_foreground%}$left_half_circle_glyph%{$yellow_background$black_foreground%} $directory_glyph  %~ %{$reset_color$yellow_foreground%}$right_half_circle_glyph\
#${git_info}
#%{$reset_color$magenta_foreground%}$%{$reset_color%} "
