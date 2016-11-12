# Colors: https://github.com/sykora/etc/blob/master/zsh/functions/spectrum/

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo '$'
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function get_load() {
  uptime | awk '{print $11}' | tr ',' ' '
}

# Determine Ruby version using RVM
# if its loaded, it'll add the prompt
function rvm_info {
  ruby_version=$(~/.rvm/bin/rvm-prompt)
  if [ -n "$ruby_version" ]; then
    echo $ruby_version
  fi
}
# the chpwd_functions line cause this to update only when the directory changes
#chpwd_functions+=(rvm_info)

PROMPT='
$FG[166]%n%{$reset_color%} \
at $FG[136]%m%{$reset_color%} \
in $FG[064]%~%{$reset_color%}\
$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

RPROMPT_PREFIX='%{'$'\e[1A''%}'
RPROMPT_SUFFIX='%{'$'\e[1B''%}'
RPROMPT='$RPROMPT_PREFIX$FG[007]$(rvm_info)%{$reset_color%} \
%{$fg_bold[red]%}[$(get_load)] \
%{$fg_bold[green]%}%*%{$reset_color%}$RPROMPT_SUFFIX'

ZSH_THEME_GIT_PROMPT_PREFIX=" on $FG[033]"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
