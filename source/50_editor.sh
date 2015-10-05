# Editing
export EDITOR='vim'
export PAGER='less'

if [[ -n "$SSH_TTY" ]] && is_osx; then
  export VISUAL='mvim -f'
  export LESSEDIT='mvim ?lm+%lm -- %f'
else
  export VISUAL="$EDITOR -gf"
fi

alias q="$EDITOR"
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q +'cd $DOTFILES'"
