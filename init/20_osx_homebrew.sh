# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# If Homebrew available, run an update
[[ ! "$(type -P brew)" ]] && e_error "Please install Homebrew." && return 1

e_header "Updating Homebrew"
brew doctor
brew update

# Functions used in subsequent init scripts.

# Install Homebrew recipes.
function brew_install_recipes() {
  recipes=($(setdiff "${recipes[*]}" "$(brew list)"))
  if (( ${#recipes[@]} > 0 )); then
    e_header "Installing Homebrew recipes: ${recipes[*]}"
    for recipe in "${recipes[@]}"; do
      brew install $recipe
  done
  fi
}
