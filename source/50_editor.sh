# Editing
if [[ ! "$SSH_TTY" ]] && is_osx; then
  export EDITOR='mvim -f'
  export LESSEDIT='mvim ?lm+%lm -- %f'
else
  export EDITOR=$(type nano pico vi vim 2>/dev/null | sed 's/ .*$//;q')
fi

export VISUAL="$EDITOR"
alias q="$EDITOR"
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q +'cd $DOTFILES'"
