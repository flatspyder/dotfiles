# ~/.zshrc - interactive Zsh configuration

export DOTFILES="$HOME/.dotfiles"

# Helper to (re)source configuration snippets
src() {
  if [[ -n "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in "$DOTFILES"/source/*.sh; do
      [[ -f "$file" ]] || continue
      case "$(basename "$file")" in
        00_dotfiles.sh|20_path.sh) continue ;;
      esac
      source "$file"
    done
  fi
}

dotfiles() {
  "$DOTFILES/bin/dotfiles" "$@" && src
}

# Initial load
src

# Load Zsh-specific customisations
for file in "$DOTFILES"/zsh/*.sh; do
  [[ -f "$file" ]] || continue
  source "$file"
done
[ -f "$DOTFILES/zsh/prompt_oligaymond_setup" ] && source "$DOTFILES/zsh/prompt_oligaymond_setup"
