# Where the magic happens
export DOTFILES=~/.dotfiles

# Source all the things
function src() {
  # If a specific file is requested, source it.
  if [[ "$1" ]]; then
    if [[ -f "$DOTFILES/source/$1.sh" ]]; then
      source "$DOTFILES/source/$1.sh"
    else
      echo "Error: $DOTFILES/source/$1.sh not found."
    fi
    return
  fi

  # Otherwise, source the curated list of files.
  local files_to_source=(
    # Core setup and path
    "00_dotfiles.sh"
    "20_path.sh"

    # Shared functions and aliases
    "50_functions.sh"
    "50_aliases.sh"

    # Shared configurations
    "50_editor.sh"
    "50_file.sh"
    "50_vcs.sh"
    "50_devel.sh"
    "50_net.sh"

    # OS-specific configurations (with guards inside)
    "50_osx.sh"
    "50_ubuntu.sh"

    # Bash-specific configurations
    "50_history.sh"
    "50_misc.sh"
    "50_prompt.sh"
  )

  for file in "${files_to_source[@]}"; do
    if [[ -f "$DOTFILES/source/$file" ]]; then
      source "$DOTFILES/source/$file"
    fi
  done
}

# Function to re-run the dotfiles installer and re-source the config
function dotfiles() {
  "$DOTFILES/bin/dotfiles" "$@" && src
}

# Initial source
src

# Add binaries into the path - this is now handled by 20_path.sh
# PATH=$DOTFILES/bin:$PATH
# export PATH
# The line above is commented out to avoid duplicating path entry.
# 20_path.sh now adds $DOTFILES/bin to the path.
