#!/bin/sh
#
# PATH configuration
#
# This script is compatible with both Bash and Zsh. It should be sourced from
# the appropriate shell startup file (e.g., .bashrc, .zshenv).

# Set GOPATH, which is used in the path below.
# This ensures it's available for both shells.
export GOPATH="$HOME/src/gocode"

# --- Zsh Setup ---
if [ -n "$ZSH_VERSION" ]; then
  # For Zsh, we manipulate the `path` array, which Zsh uses to set $PATH.
  # This avoids duplicates and is easier to manage than string manipulation.
  typeset -gU path

  # Prepending to the path array gives the directory higher precedence.
  # The order is from most to least specific.
  path=(
    # User-specific bin directories
    "$HOME/bin"
    "$HOME/.local/bin"
    "$DOTFILES/bin"

    # Language-specific bin directories
    "$GOPATH/bin"
    "/usr/local/go/bin"

    # Package managers
    "/opt/homebrew/bin" # Homebrew on Apple Silicon
    "$HOME/miniconda3/bin"

    # System paths (some may be duplicates but -U handles that)
    "/usr/local/bin"
    "/usr/local/sbin"
    "/usr/bin"
    "/usr/sbin"
    "/bin"
    "/sbin"
  )

# --- Bash Setup ---
elif [ -n "$BASH_VERSION" ]; then

  # Helper function to prepend a directory to the PATH, but only if it exists
  # and is not already in the PATH.
  path_prepend() {
    if [ -d "$1" ]; then
      case ":$PATH:" in
        *":$1:"*)
          : # Directory already in PATH
          ;;
        *)
          PATH="$1${PATH:+":$PATH"}"
          ;;
      esac
    fi
  }

  # Prepend directories to PATH. The order is from most to least specific.
  path_prepend "$HOME/bin"
  path_prepend "$HOME/.local/bin"
  path_prepend "$DOTFILES/bin"
  path_prepend "$GOPATH/bin"
  path_prepend "/usr/local/go/bin"
  path_prepend "/opt/homebrew/bin" # Homebrew on Apple Silicon
  path_prepend "$HOME/miniconda3/bin"
  path_prepend "/usr/local/bin"
  path_prepend "/usr/local/sbin"

  export PATH
  unset path_prepend

fi
