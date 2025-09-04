# Cross-shell PATH configuration

# Prepend directories to PATH if they exist and are not already present
path_prepend() {
  for dir in "$@"; do
    [ -d "$dir" ] || continue
    case ":$PATH:" in
      *":$dir:") ;;
      *) PATH="$dir:$PATH" ;;
    esac
  done
}

# Platform specific paths
if is_osx; then
  path_prepend /usr/local/bin /usr/local/sbin "$HOME/miniconda3/bin"
fi

# Language/tooling paths
path_prepend /usr/local/go/bin "$GOPATH/bin"

# User bins
path_prepend "$HOME/bin"

export PATH

# Keep zsh's path array in sync when running under zsh
if [ -n "$ZSH_VERSION" ]; then
  path=(${(s/:/)PATH})
fi
