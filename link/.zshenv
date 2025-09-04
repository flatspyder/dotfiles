# ~/.zshenv - minimal Zsh environment setup

export DOTFILES="$HOME/.dotfiles"

[ -f "$DOTFILES/source/00_dotfiles.sh" ] && source "$DOTFILES/source/00_dotfiles.sh"
[ -f "$DOTFILES/source/20_path.sh" ] && source "$DOTFILES/source/20_path.sh"
