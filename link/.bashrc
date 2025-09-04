# ~/.bashrc - shared shell configuration

export DOTFILES="$HOME/.dotfiles"

# Load helper functions and path tweaks early
[ -f "$DOTFILES/source/00_dotfiles.sh" ] && source "$DOTFILES/source/00_dotfiles.sh"
[ -f "$DOTFILES/source/20_path.sh" ] && source "$DOTFILES/source/20_path.sh"


# Helper to (re)source configuration snippets
src() {
  if [ -n "$1" ]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in "$DOTFILES"/source/*.sh; do
      [ -f "$file" ] || continue
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
