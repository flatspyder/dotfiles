# Editing
export EDITOR='vim'
export PAGER='less'

if [[ -z "$SSH_TTY" ]] && is_osx; then
  export VISUAL='mvim -f'
  export LESSEDIT='mvim ?lm+%lm -- %f'
else
  export VISUAL="$EDITOR -gf"
fi